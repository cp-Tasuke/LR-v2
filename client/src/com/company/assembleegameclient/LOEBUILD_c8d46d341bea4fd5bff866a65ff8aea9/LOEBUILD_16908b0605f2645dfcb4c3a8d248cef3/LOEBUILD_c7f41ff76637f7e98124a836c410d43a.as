package com.company.assembleegameclient.LOEBUILD_c8d46d341bea4fd5bff866a65ff8aea9.LOEBUILD_16908b0605f2645dfcb4c3a8d248cef3 {
import flash.events.Event;
import flash.utils.ByteArray;

import kabam.rotmg.servers.api.Server;

public class LOEBUILD_c7f41ff76637f7e98124a836c410d43a extends Event {

      public static const RECONNECT:String = "RECONNECT_EVENT";

      public var server_:Server;

      public var gameId_:int;

      public var createCharacter_:Boolean;

      public var charId_:int;

      public var keyTime_:int;

      public var key_:ByteArray;

      public var isFromArena_:Boolean;

      public function LOEBUILD_c7f41ff76637f7e98124a836c410d43a(param1:Server, param2:int, param3:Boolean, param4:int, param5:int, param6:ByteArray, param7:Boolean) {
         super(RECONNECT);
         this.server_ = param1;
         this.gameId_ = param2;
         this.createCharacter_ = param3;
         this.charId_ = param4;
         this.keyTime_ = param5;
         this.key_ = param6;
         this.isFromArena_ = param7;
      }

      override public function clone() : Event {
         return new LOEBUILD_c7f41ff76637f7e98124a836c410d43a(this.server_,this.gameId_,this.createCharacter_,this.charId_,this.keyTime_,this.key_,this.isFromArena_);
      }

      override public function toString() : String {
         return formatToString(RECONNECT,"server_","gameId_","charId_","keyTime_","key_","isFromArena_");
      }
   }
}
