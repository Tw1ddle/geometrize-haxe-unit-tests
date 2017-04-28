package geometrize.bitmap;

import geometrize.bitmap.Rgba;
import utest.Assert;

class RgbaTest {
	public function new() {}
	
	public function testCreateRgba() {
		Assert.equals(Rgba.create(0, 0, 0, 0), 0x00000000);
		Assert.equals(Rgba.create(255, 255, 255, 255), 0xFFFFFFFF);
		
		Assert.equals(Rgba.create(255, 255, 255, 255), Rgba.create(255, 255, 255, 255));
		Assert.equals(Rgba.create( -1, -1, -1, -1), Rgba.create( -1, -1, -1, -1));
		
		Assert.notEquals(Rgba.create(1, 2, 3, 4), Rgba.create(255, 254, 253, 252));
		Assert.notEquals(Rgba.create(1, 2, 3, 4), Rgba.create(4, 3, 2, 1));
		
		Assert.equals(0xFFFFFFFF, Rgba.create(9001, 9001, 9001, 9001));
		Assert.equals(0x00000000, Rgba.create(-9001, -9001, -9001, -9001));
		
		Assert.equals(Rgba.create(255, 0, 0, 0), 0xFF000000);
		Assert.equals(Rgba.create(0, 255, 0, 0), 0x00FF0000);
		Assert.equals(Rgba.create(0, 0, 255, 0), 0x0000FF00);
		Assert.equals(Rgba.create(0, 0, 0, 255), 0x000000FF);
		
		Assert.equals(Rgba.create(255, 0, 255, 0), 0xFF00FF00);
		Assert.equals(Rgba.create(0, 255, 0, 255), 0x00FF00FF);
	}
	
	public function testAccessors() {
		var color = Rgba.create(255, 127, 63, 31);
		Assert.equals(color.r, 255);
		Assert.equals(color.g, 127);
		Assert.equals(color.b, 63);
		Assert.equals(color.a, 31);
		
		Assert.equals(128, Rgba.fromInt(128));
		Assert.equals(-1, Rgba.fromInt(-1));
		Assert.notEquals(10, Rgba.fromInt(20));
	}
}