package;

import lime.app.Application;
import lime.graphics.Image;
import lime.system.System;
import geometrize.bitmap.Bitmap;
import geometrize.bitmap.Rgba;
import haxe.io.Bytes;
import geometrize.runner.ImageRunner;
import geometrize.exporter.SvgExporter;
import geometrize.runner.ImageRunnerOptions;
import lime.math.Rectangle;
import lime.graphics.PixelFormat;
import haxe.Json;

class Main extends Application {
	public function new() {
		super();
		allTests();
	}

	function allTests() {
		var results = [
			png_size736x552_200i_150c_250s(),
			drawnRectangle(),
			jpeg_size1214x736_2400i_60c_100s()
		];
		trace(Json.stringify(results));
		trace(Json.stringify(results, null, "  "));

		System.exit(0);
	}

  /**medium/large JPEG image  with many iterations and average/low candidateShapesPerStep and shapeMutationsPerStep **/
	function jpeg_size1214x736_2400i_60c_100s() {
		var testName = 'jpeg_size1214x736_2400i_60c_100s';
		var iterations = 2400;
		var options:ImageRunnerOptions = {
			shapeTypes: TestUtil.allShapeTypes(),
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
			timeFormatted: TestUtil.msPretty(t),
			options: options,
			iterations: iterations,
			bitmapSize: bitmap.getBytes().length
		}
	}

	/** a test using medium size image with few iterations but relatively large values for candidateShapesPerStep and shapeMutationsPerStep **/
	function png_size736x552_200i_150c_250s() {
		var testName = 'png_size736x552_200i_150c_250s';
		var iterations = 200;
		var options:ImageRunnerOptions = {
			shapeTypes: TestUtil.allShapeTypes(),
			alpha: 128,
			candidateShapesPerStep: 150,
			shapeMutationsPerStep: 250
		};
		var image = Image.fromFile(CWD + "testAssets/photo.png");
		image.format = PixelFormat.RGBA32;
		var bitmap = Bitmap.createFromBytes(image.width, image.height, image.data.toBytes());
		var t = testDefinition(testName, options, iterations, bitmap);
		return {
			testName: testName,
			time: Std.int(t),
			timeFormatted: TestUtil.msPretty(t),
			options: options,
			iterations: iterations,
			bitmapSize: bitmap.getBytes().length
		}
	}

	/** a test that builds a bitmap manually **/
	function drawnRectangle() {
		var testName = 'drawnRectangle';
		var iterations = 200;
		var bitmapSize = 400;
		var options:ImageRunnerOptions = {
			shapeTypes: TestUtil.allShapeTypes(),
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
			timeFormatted: TestUtil.msPretty(t),
			options: options,
			iterations: iterations,
			bitmapSize: bitmap.getBytes().length
		};
	}

	function testDefinition(testName:String, options:ImageRunnerOptions, iterations:Int, bitmap:Bitmap) {
		trace('Starting ' + testName);
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

	public static macro function cwd():haxe.macro.Expr.ExprOf<String> {
		return macro $v{Sys.getCwd()};
	}

	static var CWD = cwd();
}
