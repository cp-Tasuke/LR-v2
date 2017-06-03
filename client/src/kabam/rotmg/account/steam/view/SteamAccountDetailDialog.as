package kabam.rotmg.account.steam.view {
import com.company.assembleegameclient.account.ui.Frame;
import com.company.assembleegameclient.ui.DeprecatedClickableText;

import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;

import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;

import org.osflash.signals.Signal;

public class SteamAccountDetailDialog extends Sprite {

      public var done:Signal;

      public var register:Signal;

      public var link:Signal;

      private var loginText_:TextFieldDisplayConcrete;

      private var usernameText_:TextFieldDisplayConcrete;

      private var webLoginText_:TextFieldDisplayConcrete;

      private var emailText_:TextFieldDisplayConcrete;

      private var register_:DeprecatedClickableText;

      public function SteamAccountDetailDialog() {
         super();
         this.done = new Signal();
         this.register = new Signal();
      }

      public function setInfo(param1:String, param2:String, param3:Boolean) : void {
         var _local4:Frame = null;
         _local4 = new Frame(TextKey.DETAIL_DIALOG_TITLE,"",TextKey.STEAM_ACCOUNT_DETAIL_DIALOG_RIGHTBUTTON,"/steamworksCurrentLogin");
         addChild(_local4);
         this.loginText_ = new TextFieldDisplayConcrete().setSize(18).setColor(11776947);
         this.loginText_.setBold(true);
         this.loginText_.setStringBuilder(new LineBuilder().setParams(TextKey.STEAM_ACCOUNT_DETAIL_DIALOG_STEAMWORKS_USER));
         this.loginText_.filters = [new DropShadowFilter(0,0,0)];
         this.loginText_.y = _local4.h_ - 60;
         this.loginText_.x = 17;
         _local4.addChild(this.loginText_);
         this.usernameText_ = new TextFieldDisplayConcrete().setSize(16).setColor(11776947);
         this.usernameText_.setTextWidth(238).setTextHeight(30);
         this.usernameText_.setStringBuilder(new StaticStringBuilder(param1));
         this.usernameText_.y = _local4.h_ - 30;
         this.usernameText_.x = 17;
         _local4.addChild(this.usernameText_);
         _local4.h_ = _local4.h_ + 88;
         if(param3) {
            _local4.h_ = _local4.h_ - 20;
            this.webLoginText_ = new TextFieldDisplayConcrete().setSize(18).setColor(11776947);
            this.webLoginText_.setBold(true);
            this.webLoginText_.setStringBuilder(new LineBuilder().setParams(TextKey.STEAM_ACCOUNT_DETAIL_DIALOG_LINKWEB));
            this.webLoginText_.filters = [new DropShadowFilter(0,0,0)];
            this.webLoginText_.y = _local4.h_ - 60;
            this.webLoginText_.x = 17;
            _local4.addChild(this.webLoginText_);
            this.emailText_ = new TextFieldDisplayConcrete().setSize(16).setColor(11776947);
            this.emailText_.setStringBuilder(new StaticStringBuilder(param2));
            this.emailText_.y = _local4.h_ - 30;
            this.emailText_.x = 17;
            _local4.addChild(this.emailText_);
            _local4.h_ = _local4.h_ + 88;
         } else {
            this.register_ = new DeprecatedClickableText(12,false,TextKey.STEAM_ACCOUNT_DETAIL_DIALOG_REGISTER);
            this.register_.addEventListener(MouseEvent.CLICK,this.onRegister);
            _local4.addNavigationText(this.register_);
         }
         _local4.rightButton_.addEventListener(MouseEvent.CLICK,this.onContinue);
      }

      private function onContinue(param1:MouseEvent) : void {
         this.done.dispatch();
      }

      public function onRegister(param1:MouseEvent) : void {
         this.register.dispatch();
      }
   }
}
