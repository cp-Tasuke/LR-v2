package kabam.rotmg.core.commands {
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.LOEBUILD_efda783509bc93eea698457c87bbee3f;

import kabam.rotmg.pets.data.PetVO;
import kabam.rotmg.pets.data.PetYardEnum;
import kabam.rotmg.pets.data.PetsModel;

import robotlegs.bender.bundles.mvcs.Command;

public class UpdatePetsModelCommand extends Command {

      [Inject]
      public var model:PetsModel;

      [Inject]
      public var data:XML;

      public function UpdatePetsModelCommand() {
         super();
      }

      override public function execute() : void {
         if(this.data.Account.hasOwnProperty("PetYardType")) {
            this.model.setPetYardType(this.parseYardFromXML());
         }
         if(this.data.hasOwnProperty("Pet")) {
            this.model.setActivePet(this.parsePetFromXML());
         }
      }

      private function parseYardFromXML() : int {
         var _local1:String = PetYardEnum.selectByOrdinal(this.data.Account.PetYardType).value;
         var _local2:XML = LOEBUILD_efda783509bc93eea698457c87bbee3f.getXMLfromId(_local1);
         return _local2.@type;
      }

      private function parsePetFromXML() : PetVO {
         var _local1:XMLList = this.data.Pet;
         var _local2:PetVO = this.model.getPetVO(_local1.@instanceId);
         _local2.apply(_local1[0]);
         return _local2;
      }
   }
}
