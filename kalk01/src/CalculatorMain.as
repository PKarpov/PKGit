package 
{
	import com.creativebottle.starlingmvc.beans.Bean;
	import com.creativebottle.starlingmvc.config.StarlingMVCConfig;
	import com.creativebottle.starlingmvc.StarlingMVC;
	import starling.display.Sprite;
	import view.Calculator;
	import model.CModel;
	
	/**
	 * ...
	 * @author fish
	 */
	public class CalculatorMain extends Sprite
	{
		private var starlingMVC:StarlingMVC;
		
		public function CalculatorMain() {
			var config:StarlingMVCConfig = new StarlingMVCConfig();
			//config.eventPackages = ["controller.events"];
			var calculator:Calculator = new Calculator;
			var beans:Array = [new Bean(new CModel(),"logic"), calculator];
			starlingMVC = new StarlingMVC(this, config, beans);
			addChild(calculator);
		}
		
	}

}