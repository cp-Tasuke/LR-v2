package kabam.rotmg.news.services {
import com.company.assembleegameclient.ui.dialogs.ErrorDialog;

import flash.utils.getTimer;

import kabam.lib.tasks.BaseTask;
import kabam.rotmg.appengine.api.AppEngineClient;
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.language.model.LanguageModel;
import kabam.rotmg.news.model.NewsCellLinkType;
import kabam.rotmg.news.model.NewsCellVO;
import kabam.rotmg.news.model.NewsModel;

public class GetAppEngineNewsTask extends BaseTask implements GetNewsTask {

      private static const TEN_MINUTES:int = 600;

      [Inject]
      public var client:AppEngineClient;

      [Inject]
      public var openDialog:OpenDialogSignal;

      [Inject]
      public var model:NewsModel;

      [Inject]
      public var languageModel:LanguageModel;

      private var lastRan:int = -1;

      private var numUpdateAttempts:int = 0;

      private var updateCooldown:int = 600;

      public function GetAppEngineNewsTask() {
         super();
      }

      override protected function startTask() : void {
         this.numUpdateAttempts++;
         if(this.lastRan == -1 || this.lastRan + this.updateCooldown < getTimer() / 1000) {
            this.lastRan = getTimer() / 1000;
            this.client.complete.addOnce(this.onComplete);
            this.client.sendRequest("/app/globalNews",{"language":this.languageModel.getLanguage()});
         } else {
            completeTask(true);
            reset();
         }
         if("production".toLowerCase() != "dev" && this.updateCooldown != 0 && this.numUpdateAttempts >= 2) {
            this.updateCooldown = 0;
         }
      }

      private function onComplete(param1:Boolean, param2:*) : void {
         if(param1) {
            this.onNewsRequestDone(param2);
         } else {
            this.onNewsRequestError(param2);
         }
         completeTask(param1,param2);
         reset();
      }

      private function onNewsRequestDone(param1:String) : void {
         var _local4:Object = null;
         var _local2:Vector.<NewsCellVO> = new Vector.<NewsCellVO>();
         var _local3:Object = JSON.parse(param1);
         for each(_local4 in _local3) {
            _local2.push(this.returnNewsCellVO(_local4));
         }
         this.model.updateNews(_local2);
      }

      private function returnNewsCellVO(param1:Object) : NewsCellVO {
         var _local2:NewsCellVO = new NewsCellVO();
         _local2.headline = param1.title;
         _local2.imageURL = param1.image;
         _local2.linkDetail = param1.linkDetail;
         _local2.startDate = Number(param1.startTime);
         _local2.endDate = Number(param1.endTime);
         _local2.linkType = NewsCellLinkType.parse(param1.linkType);
         _local2.networks = String(param1.platform).split(",");
         _local2.priority = uint(param1.priority);
         _local2.slot = uint(param1.slot);
         return _local2;
      }

      private function onNewsRequestError(param1:String) : void {
         this.openDialog.dispatch(new ErrorDialog("Unable to get news data."));
      }
   }
}
