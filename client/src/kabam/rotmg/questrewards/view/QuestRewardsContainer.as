package kabam.rotmg.questrewards.view {
import flash.display.Sprite;
import flash.events.Event;

public class QuestRewardsContainer extends Sprite {

      public static var modalIsOpen:Boolean = false;

      public function QuestRewardsContainer() {
         modalIsOpen = true;
         addEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStage);
         super();
      }

      public function removedFromStage(param1:Event) : void {
         modalIsOpen = false;
      }
   }
}
