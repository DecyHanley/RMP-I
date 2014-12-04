package {
	public class EmbeddedAssets {
		[Embed(source = "assets/sprites/SpriteSheet.xml", mimeType = "application/octet-stream")]
		public static const ATLAS_XML: Class;
		[Embed(source = "assets/sprites/SpriteSheet.png")]
		public static const ATLAS_TEXTURE: Class;
	}
	
}
