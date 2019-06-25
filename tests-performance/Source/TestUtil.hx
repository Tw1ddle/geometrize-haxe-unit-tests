package;

import geometrize.Util;
import geometrize.bitmap.Bitmap;
import geometrize.bitmap.Rgba;
import geometrize.runner.ImageRunner;
import geometrize.exporter.SvgExporter;
import geometrize.runner.ImageRunnerOptions;
import haxe.io.Bytes;

class TestUtil {

	public static function msFrom(t0:Float):Float {
		return Math.round(now() - t0);
	}

	public static function msPretty(t:Float):String {
		return Math.round(t / 1000) + " seconds";
	}

	public static function traceFrom(t0:Float):Void {
		trace(msPretty(msFrom(t0)));
	}

	public static function now():Float {
		#if js
  		untyped return Date.now() * 1.0;
		#elseif neko
	  	return Sys.time() * 1000.0;
		#end
		  return Date.now().getTime();
	}

}


/**
 * stores current git commit hash.
 **/
class Version {
  public static macro function getGitCommitHash():haxe.macro.Expr.ExprOf<String> {
    #if !display
    var process = new sys.io.Process('git', ['rev-parse', 'HEAD']);
    if (process.exitCode() != 0) {
      var message = process.stderr.readAll().toString();
      var pos = haxe.macro.Context.currentPos();
      haxe.macro.Context.error("Cannot execute `git rev-parse HEAD`. " + message, pos);
    }
    var commitHash:String = process.stdout.readLine();
    return macro $v{commitHash};
    #else 
    var commitHash:String = "";
    return macro $v{commitHash};
    #end
  }
}