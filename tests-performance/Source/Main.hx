package;

import lime.app.Application;
import lime.graphics.Image;
import lime.system.System;
import geometrize.bitmap.Bitmap;
import geometrize.bitmap.Rgba;
import haxe.io.Bytes;
import geometrize.shape.ShapeType;
import geometrize.runner.ImageRunner;
import geometrize.exporter.SvgExporter;
import geometrize.runner.ImageRunnerOptions;
import lime.math.Rectangle;
import lime.graphics.PixelFormat;
import haxe.Json;

class Main extends Application {
	public static macro function cwd():haxe.macro.Expr.ExprOf<String> {
		return macro $v{Sys.getCwd()};
	}

	static var CWD = cwd();

	public function new() {
		super();
		allTests();
	}

	function allTests() {
		var results = [size736x552_400i_100c_200s(), drawnRectangle(), jpeg_size736x552_400i_100c_200s()];
		trace(Json.stringify(results));
		trace(Json.stringify(results, null, "  "));

		System.exit(0);
	}

	function jpeg_size736x552_400i_100c_200s() {
    var testName = 'jpeg_size736x552_400i_100c_200s';
		var iterations = 2400;
		var options:ImageRunnerOptions = {
			shapeTypes: allShapeTypes(),
			alpha: 128,
			candidateShapesPerStep: 60,
			shapeMutationsPerStep: 100
		};
		var image = Image.fromFile(CWD + "testAssets/cabo2.jpeg");
		image.format = PixelFormat.RGBA32;
		var bitmap = Bitmap.createFromBytes(image.width, image.height, image.data.toBytes());
		var t = testDefinition(testName, options, iterations, bitmap);
		return {
      testName: testName,
			time: Std.int(t),
      timeFormatted:TestUtil.msPretty(t),
			options: options,
			iterations: iterations,
			bitmapSize: bitmap.getBytes().length
		}
	}

	function size736x552_400i_100c_200s() {
    var testName = 'size736x552_400i_100c_200s';
		var iterations = 400;
		var options:ImageRunnerOptions = {
			shapeTypes: allShapeTypes(),
			alpha: 128,
			candidateShapesPerStep: 100,
			shapeMutationsPerStep: 200
		};
		var image = Image.fromFile(CWD + "testAssets/photo.png");
		image.format = PixelFormat.RGBA32;
		var bitmap = Bitmap.createFromBytes(image.width, image.height, image.data.toBytes());
		var t = testDefinition(testName, options, iterations, bitmap);
		return {
      testName: testName,
			time: Std.int(t),
      timeFormatted:TestUtil.msPretty(t),
			options: options,
			iterations: iterations,
			bitmapSize: bitmap.getBytes().length
		}
	}

	function drawnRectangle() {
    var testName = 'drawnRectangle';
		var iterations = 200;
		var bitmapSize = 400;
		var options:ImageRunnerOptions = {
			shapeTypes: allShapeTypes(),
			alpha: 128,
			candidateShapesPerStep: 50,
			shapeMutationsPerStep: 100
		};
		var bitmap = Bitmap.create(bitmapSize, bitmapSize, Rgba.create(255, 255, 255, 255));
		for (i in Math.round(bitmapSize / 5)...Math.round(bitmapSize / 2)) {
			for (j in Math.round(bitmapSize / 5)...Math.round(bitmapSize / 2)) {
				bitmap.setPixel(i, j, Rgba.create(255, 0, 0, 255));
			}
		}
		var t = testDefinition(testName, options, iterations, bitmap);
		return {
      testName: testName,
			time: Std.int(t),
      timeFormatted:TestUtil.msPretty(t),
			options: options,
			iterations: iterations,
			bitmapSize: bitmap.getBytes().length
		};
	}

	function testDefinition(testName:String, options:ImageRunnerOptions, iterations:Int, bitmap:Bitmap) {
    trace('starting '+testName);
		var t0 = TestUtil.now();
		var runner = new ImageRunner(bitmap, Rgba.create(255, 255, 255, 255));
		var svgData = [];
		for (i in 0...iterations) {
			var result = runner.step(options);
			svgData.push(SvgExporter.exportShapes(result));
		}
		var svg = SvgExporter.getSvgPrelude() + SvgExporter.getSvgNodeOpen(bitmap.width, bitmap.height) + svgData.join('\n') + SvgExporter.getSvgNodeClose();

		Sure.sure(svg.indexOf("<svg") != -1);

		var out = sys.io.File.write(CWD + "tmp_" + testName + ".svg", true);
		out.writeString(svg);
		out.close();
		return TestUtil.now() - t0;
	}

	function allShapeTypes() {
		return [
			ShapeType.RECTANGLE,
			ShapeType.ROTATED_RECTANGLE,
			ShapeType.TRIANGLE,
			ShapeType.ELLIPSE,
			ShapeType.ROTATED_ELLIPSE,
			ShapeType.CIRCLE,
			ShapeType.LINE
		];
	}
}
