package 
{
	import com.xperiment.ASStatc.Normal;
	import com.xperiment.ASStat;
	import com.xperiment.ASStatc.Studentt;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author 
	 */
	public class Main extends Sprite 
	{
		import com.xperiment.ASStatc.Normal;
		
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
			
		var s:Number = 1- Normal.cdf(3, 4, 2)
			trace(s,22)
			
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
		
		
		
		
		
		
		
		
		
				//Calculate df for Student's t
		public static function degreesOfFreedom(n1:Number, n2:Number, mean1:Number, mean2:Number, sd1:Number, sd2:Number, varianceAssumption:Boolean = false):Number{
		  if(varianceAssumption != false || (isNaN(mean1) && isNaN(mean2) && isNaN(sd1) && isNaN(sd2))){
			return(n1 + n2 - 2);
		  }
		  else{ //Return Welch's df
			return((Math.pow(Math.pow(sd1, 2) / n1 + Math.pow(sd2, 2) / n2, 2) / (Math.pow(sd1, 4) / (Math.pow(n1, 2) * (n1 - 1)) + Math.pow(sd2, 4) / (Math.pow(n2, 2) * (n2 - 1)))));
		  }
		}

		//Calculate Student's t
		public static function studentsT(n1:Number, n2:Number, m1:Number, m2:Number, sd1:Number, sd2:Number, varianceAssumption:Boolean = false):Number{
		  if(varianceAssumption != false){
			return((m1 - m2) / (Math.sqrt(((n1 - 1) * Math.pow(sd1, 2) + (n2 - 1) * Math.pow(sd2, 2)) / (n1 + n2 - 2)) * Math.sqrt((1 / n1) + (1 / n2))));
		  }
		  else{
			return((m1 - m2) / Math.sqrt((Math.pow(sd1, 2) / n1) + (Math.pow(sd2, 2) / n2)));
		  }
		}

		//Calculate MOE for Mdiff, Student's t, and Cohen's d
		public static function studentsTMOE(alpha:Number, df:Number, studentsT:Number, mDiff:Number, n1:Number, n2:Number, cohensD:Number, calculate:String):Number{
		  //Calculate critical t

		  var critical_t:Number = Studentt.inv(1 - (alpha / 2), df);
		  
		  switch(calculate){
			//MOE for Mdiff
			case "mdiff":
			  var se_mean:Number = mDiff / studentsT;
			  return(critical_t * se_mean);
			break;
			
			//MOE for Cohen's d
			case "cohensd":
			  return(critical_t * Math.sqrt((n1 + n2) / (n1 * n2) + (Math.pow(cohensD, 2) / (2 * (n1 + n2 - 2))) * ((n1 + n2) / (n1 + n2 - 2))));
			break;
		  }
		  throw new Error();
		  return 0;
		}


		//Convert Student's t another effect size
		public static function studentsTToES(studentsT:Number, n1:Number, n2:Number, convertTo:String):Number{
		  //Calculate total sample size
		  var df:Number = n1 + n2;
		  
		  switch(convertTo){
			//Cohen's d
			case "cohensD":
			  return(studentsT / Math.sqrt((n1 / df) * (n2 / df) * (df - 2)));
			break;
			
			//Hedge's g
			case "hedgesG":
			  return(studentsT / Math.sqrt((n1 / df) * (n2 / df) * (df)));
			break;
			
			//Hedge's g unbiased or Delta hat
			case "hedgesGUnbiased":
			  return((studentsT / Math.sqrt((n1 / df) * (n2 / df) * (df))) * ((df - 3) / (df - 2.25)));
			break;
		  
			//Pearson's r
			case "pearsonsR":
			  return(Math.sqrt(Math.pow(studentsT, 2) / (Math.pow(studentsT, 2) + df - 2)));
			break;
			
			//Cohen's f squared
			case "cohensFSquared":
			  return(Math.pow(studentsT, 2) / ((Math.pow(studentsT, 2) + df - 2) * (1 - (Math.pow(studentsT, 2) / (Math.pow(studentsT, 2) + df - 2)))) );
			break;
		  }
		  throw new Error();
		  return 0;
		}

		//Convert effect size to Student's T
		public static function ESToStudentsT(effectSize:Number, n1:Number, n2:Number, convertFrom:String):Number{
		  //Calculate total sample size
		  var df:Number = n1 + n2;
		  
		  switch(convertFrom){
		  
		  //Cohen's d
		  case "cohensD":
			return(effectSize * Math.sqrt((n1 / df) * (n2 / df) * (df - 2)));
		  break;
		  
		  //Hedge's g
		  case "hedgesG":
			return(effectSize * Math.sqrt((n1 / df) * (n2 / df) * (df)));
		  break;
		  
		  //Hedge's g unbiased or Delta hat
		  case "hedgesGUnbiased":
			return(((effectSize * (df - 2.25)) / (df - 3)) * Math.sqrt((n1 / df) * (n2 / df) * (df)));
			break;

		  //Pearson's r
		  case "pearsonsR":
			return((effectSize * Math.sqrt(df - 2)) / Math.sqrt(1 - Math.pow(effectSize, 2)));
		  break;
		  
		  //Cohen's f squared
		  case "cohensFSquared":
			return(Math.sqrt((effectSize * (df - 2) / (effectSize + 1)) / (1 - effectSize / (effectSize + 1))));
		  break;
		  throw new Error();
		  return 0;
		  }
		  throw new Error();
		  return 0;
		}

		
	}
	
}