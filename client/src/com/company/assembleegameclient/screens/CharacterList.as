package com.company.assembleegameclient.screens {
import com.company.assembleegameclient.screens.charrects.CharacterRectList;

import flash.display.Graphics;
import flash.display.Shape;
import flash.display.Sprite;

import kabam.rotmg.core.model.PlayerModel;

public class CharacterList extends Sprite {

      public static const WIDTH:int = 760;

      public static const HEIGHT:int = 415;

      public static const TYPE_CHAR_SELECT:int = 1;

      public static const TYPE_GRAVE_SELECT:int = 2;

      public var charRectList_:Sprite;

      public function CharacterList(param1:PlayerModel, param2:int) {
         var _local3:Shape = null;
         var _local4:Graphics = null;
         super();
         switch(param2) {
            case TYPE_CHAR_SELECT:
               this.charRectList_ = new CharacterRectList();
               break;
            case TYPE_GRAVE_SELECT:
               this.charRectList_ = new Graveyard(param1);
               break;
            default:
               this.charRectList_ = new Sprite();
         }
         addChild(this.charRectList_);
         if(height > 400) {
            _local3 = new Shape();
            _local4 = _local3.graphics;
            _local4.beginFill(0);
            _local4.drawRect(0,0,WIDTH,HEIGHT);
            _local4.endFill();
            addChild(_local3);
            mask = _local3;
         }
      }

      public function setPos(param1:Number) : void {
         this.charRectList_.y = param1;
      }
   }
}
