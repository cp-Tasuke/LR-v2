package com.company.assembleegameclient.ui.options {
import com.company.assembleegameclient.LOEBUILD_166e64f6c3677d0c513901242a3e702d.LOEBUILD_3225a10b07f1580f10dee4abc3779e6c;
import com.company.util.MoreColorUtil;

import flash.events.Event;

public class KeyMapper extends BaseOption {

      private var keyCodeBox_:KeyCodeBox;

      private var disabled_:Boolean;

      public function KeyMapper(param1:String, param2:String, param3:String, param4:Boolean = false) {
         super(param1,param2,param3);
         this.keyCodeBox_ = new KeyCodeBox(LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_[paramName_]);
         this.keyCodeBox_.addEventListener(Event.CHANGE,this.onChange);
         addChild(this.keyCodeBox_);
         this.setDisabled(param4);
      }

      public function setDisabled(param1:Boolean) : void {
         this.disabled_ = param1;
         transform.colorTransform = !!this.disabled_?MoreColorUtil.darkCT:MoreColorUtil.identity;
         mouseEnabled = !this.disabled_;
         mouseChildren = !this.disabled_;
      }

      override public function refresh() : void {
         this.keyCodeBox_.setKeyCode(LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_[paramName_]);
      }

      private function onChange(param1:Event) : void {
         LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.setKey(paramName_,this.keyCodeBox_.value());
         LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.save();
      }
   }
}
