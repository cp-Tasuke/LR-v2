package kabam.rotmg.game.view {
import com.company.assembleegameclient.LOEBUILD_c8d46d341bea4fd5bff866a65ff8aea9.GameSprite;
import com.company.assembleegameclient.ui.panels.Panel;

import flash.filters.DropShadowFilter;
import flash.text.TextFieldAutoSize;

import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

public class TextPanel extends Panel {

      private var textField:TextFieldDisplayConcrete;

      private var virtualWidth:Number;

      private var virtualHeight:Number;

      public function TextPanel(param1:GameSprite) {
         super(param1);
         this.initTextfield();
      }

      public function init(param1:String) : void {
         this.textField.setStringBuilder(new LineBuilder().setParams(param1));
         this.textField.setAutoSize(TextFieldAutoSize.CENTER).setVerticalAlign(TextFieldDisplayConcrete.MIDDLE);
         this.textField.x = WIDTH / 2;
         this.textField.y = HEIGHT / 2;
      }

      private function initTextfield() : void {
         this.textField = new TextFieldDisplayConcrete().setSize(16).setColor(16777215);
         this.textField.setBold(true);
         this.textField.setStringBuilder(new LineBuilder().setParams(TextKey.TEXTPANEL_GIFTCHESTISEMPTY));
         this.textField.filters = [new DropShadowFilter(0,0,0)];
         addChild(this.textField);
      }
   }
}
