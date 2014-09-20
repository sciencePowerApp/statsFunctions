package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author 
	 */
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			//chiSquare
			qchisq(.1, 4);
			pchisq(1.1, 3);
			
			//F distribution
			qf(.1, 4, 3);
			qf(3, 4, 3);
			
			//Students t Dist
			qt(.1, 3);
			pt(4.1, 3);
			
			//Normal Dist
			qnorm(.1,.3,.4);
			pnorm(5, .3, .4);
			
			trace(1)
		}
		
		private function qchisq(p:Number, df:int):Number 
		{
			return 1; //chiSquare
		}
		
		private function pchisq(chi:Number, df:int):Number 
		{
			return .1; //p
		}
		
		
		private function qf(p:Number, df1:int, df2:int):Number {
			
			return 3.3 //F
		}
		
		private function pf(F:Number, df1:int, df2:int):Number {
			
			return .1 //p
		}
		
		
		
		private function qt(p:Number, df:int):Number {
			
			return .1 //t
		}
		
		private function pt(t:Number, df:int):Number {
			
			return .1 //p
		}
		
		
		private function qnorm(p:Number, u:Number, tau:Number):Number {
			return 2 //Z
		}
		
		private function pnorm(Z:Number, u:Number, tau:Number):Number {
			return .2 //p
		}

		
	}
	
}