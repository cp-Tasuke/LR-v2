package com.company.assembleegameclient.map {
import kabam.rotmg.game.view.components.QueuedStatusText;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

import robotlegs.bender.bundles.mvcs.Mediator;

public class LOEBUILD_d62fd05794139492f59761c5fd97a976 extends Mediator {

      [Inject]
      public var view:Map;

      [Inject]
      public var queueStatusText:LOEBUILD_a2df85b914fd649750056f699bc0d502;

      public function LOEBUILD_d62fd05794139492f59761c5fd97a976() {
         super();
      }

      override public function initialize() : void {
         this.queueStatusText.add(this.onQueuedStatusText);
      }

      override public function destroy() : void {
         this.queueStatusText.remove(this.onQueuedStatusText);
      }

      private function onQueuedStatusText(param1:String, param2:uint) : void {
         this.view.player_ && this.queueText(param1,param2);
      }

      private function queueText(param1:String, param2:uint) : void {
         var _local3:QueuedStatusText = new QueuedStatusText(this.view.player_,new LineBuilder().setParams(param1),param2,2000,0);
         this.view.mapOverlay_.addQueuedText(_local3);
      }
   }
}
