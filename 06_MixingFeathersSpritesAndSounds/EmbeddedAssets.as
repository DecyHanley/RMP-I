package {
	public class EmbeddedAssets {
		[Embed(source = 'sounds/ItsAMeMario.mp3')]
		public static const Sound1: Class;
		//[Embed(source = 'sounds/.mp3')]
		//public static const Sound2: Class;
		[Embed(source = 'sounds/BowserGreeting.mp3')]
		public static const Sound3: Class;
	}
}
