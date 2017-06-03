package com.junkbyte.console.core {
import com.junkbyte.console.Console;
import com.junkbyte.console.vos.WeakObject;

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.events.Event;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.utils.ByteArray;
import flash.utils.Dictionary;
import flash.utils.describeType;
import flash.utils.getDefinitionByName;
import flash.utils.getQualifiedClassName;

public class LogReferences extends ConsoleCore {

      public static const INSPECTING_CHANNEL:String = "⌂";

      private var _refMap:WeakObject;

      private var _refRev:Dictionary;

      private var _refIndex:uint = 1;

      private var _dofull:Boolean;

      private var _current;

      private var _history:Array;

      private var _hisIndex:uint;

      private var _prevBank:Array;

      private var _currentBank:Array;

      private var _lastWithdraw:uint;

      public function LogReferences(param1:Console) {
         var console:Console = param1;
         this._refMap = new WeakObject();
         this._refRev = new Dictionary(true);
         this._prevBank = new Array();
         this._currentBank = new Array();
         super(console);
         remoter.registerCallback("ref",function(param1:ByteArray):void {
            handleString(param1.readUTF());
         });
         remoter.registerCallback("focus",this.handleFocused);
      }

      public static function EscHTML(param1:String) : String {
         return param1.replace(new RegExp("<","g"),"&lt;").replace(new RegExp("\\>","g"),"&gt;").replace(new RegExp("\\x00","g"),"");
      }

      public static function ShortClassName(param1:Object, param2:Boolean = true) : String {
         var _local3:String = getQualifiedClassName(param1);
         var _local4:int = _local3.indexOf("::");
         var _local5:String = param1 is Class?"*":"";
         _local3 = _local5 + _local3.substring(_local4 >= 0?Number(_local4 + 2):Number(0)) + _local5;
         if(param2) {
            return EscHTML(_local3);
         }
         return _local3;
      }

      public function update(param1:uint) : void {
         if(Boolean(this._currentBank.length) || Boolean(this._prevBank.length)) {
            if(param1 > this._lastWithdraw + config.objectHardReferenceTimer * 1000) {
               this._prevBank = this._currentBank;
               this._currentBank = new Array();
               this._lastWithdraw = param1;
            }
         }
      }

      public function setLogRef(param1:*) : uint {
         var _local3:int = 0;
         if(!config.useObjectLinking) {
            return 0;
         }
         var _local2:uint = this._refRev[param1];
         if(!_local2) {
            _local2 = this._refIndex;
            this._refMap[_local2] = param1;
            this._refRev[param1] = _local2;
            if(config.objectHardReferenceTimer) {
               this._currentBank.push(param1);
            }
            this._refIndex++;
            _local3 = _local2 - 50;
            while(_local3 >= 0) {
               if(this._refMap[_local3] === null) {
                  delete this._refMap[_local3];
               }
               _local3 = _local3 - 50;
            }
         }
         return _local2;
      }

      public function getRefId(param1:*) : uint {
         return this._refRev[param1];
      }

      public function getRefById(param1:uint) : * {
         return this._refMap[param1];
      }

      public function makeString(param1:*, param2:* = null, param3:Boolean = false, param4:int = -1) : String {
         var txt:String = null;
         var v:* = undefined;
         var err:Error = null;
         var stackstr:String = null;
         var str:String = null;
         var len:int = 0;
         var hasmaxlen:Boolean = false;
         var i:int = 0;
         var strpart:String = null;
         var add:String = null;
         var o:* = param1;
         var prop:* = param2;
         var html:Boolean = param3;
         var maxlen:int = param4;
         try {
            v = !!prop?o[prop]:o;
         }
         catch(err:Error) {
            return "<p0><i>" + err.toString() + "</i></p0>";
         }
         if(v is Error) {
            err = v as Error;
            stackstr = !!err.hasOwnProperty("getStackTrace")?err.getStackTrace():err.toString();
            if(stackstr) {
               return stackstr;
            }
            return err.toString();
         }
         if(v is XML || v is XMLList) {
            return this.shortenString(EscHTML(v.toXMLString()),maxlen,o,prop);
         }
         if(v is QName) {
            return String(v);
         }
         if(v is Array || getQualifiedClassName(v).indexOf("__AS3__.vec::Vector.") == 0) {
            str = "[";
            len = v.length;
            hasmaxlen = maxlen >= 0;
            i = 0;
            while(i < len) {
               strpart = this.makeString(v[i],null,false,maxlen);
               str = str + ((!!i?", ":"") + strpart);
               maxlen = maxlen - strpart.length;
               if(Boolean(hasmaxlen) && maxlen <= 0 && i < len - 1) {
                  str = str + (", " + this.genLinkString(o,prop,"..."));
                  break;
               }
               i++;
            }
            return str + "]";
         }
         if(Boolean(config.useObjectLinking) && Boolean(v) && typeof v == "object") {
            add = "";
            if(v is ByteArray) {
               add = " position:" + v.position + " length:" + v.length;
            } else if(v is Date || v is Rectangle || v is Point || v is Matrix || v is Event) {
               add = " " + String(v);
            } else if(v is DisplayObject && Boolean(v.name)) {
               add = " " + v.name;
            }
            txt = "{" + this.genLinkString(o,prop,ShortClassName(v)) + EscHTML(add) + "}";
         } else {
            if(v is ByteArray) {
               txt = "[ByteArray position:" + ByteArray(v).position + " length:" + ByteArray(v).length + "]";
            } else {
               txt = String(v);
            }
            if(!html) {
               return this.shortenString(EscHTML(txt),maxlen,o,prop);
            }
         }
         return txt;
      }

      public function makeRefTyped(param1:*) : String {
         if(Boolean(param1) && Boolean(typeof param1 == "object") && !(param1 is QName)) {
            return "{" + this.genLinkString(param1,null,ShortClassName(param1)) + "}";
         }
         return ShortClassName(param1);
      }

      private function genLinkString(param1:*, param2:*, param3:String) : String {
         if(Boolean(param2) && !(param2 is String)) {
            param1 = param1[param2];
            param2 = null;
         }
         var _local4:uint = this.setLogRef(param1);
         if(_local4) {
            return "<menu><a href=\'event:ref_" + _local4 + (!!param2?"_" + param2:"") + "\'>" + param3 + "</a></menu>";
         }
         return param3;
      }

      private function shortenString(param1:String, param2:int, param3:*, param4:* = null) : String {
         if(param2 >= 0 && param1.length > param2) {
            param1 = param1.substring(0,param2);
            return param1 + this.genLinkString(param3,param4," ...");
         }
         return param1;
      }

      private function historyInc(param1:int) : void {
         this._hisIndex = this._hisIndex + param1;
         var _local2:* = this._history[this._hisIndex];
         if(_local2) {
            this.focus(_local2,this._dofull);
         }
      }

      public function handleRefEvent(param1:String) : void {
         var _local2:ByteArray = null;
         if(remoter.remoting == Remoting.RECIEVER) {
            _local2 = new ByteArray();
            _local2.writeUTF(param1);
            remoter.send("ref",_local2);
         } else {
            this.handleString(param1);
         }
      }

      private function handleString(param1:String) : void {
         var _local2:int = 0;
         var _local3:uint = 0;
         var _local4:String = null;
         var _local5:int = 0;
         var _local6:Object = null;
         if(param1 == "refexit") {
            this.exitFocus();
            console.setViewingChannels();
         } else if(param1 == "refprev") {
            this.historyInc(-2);
         } else if(param1 == "reffwd") {
            this.historyInc(0);
         } else if(param1 == "refi") {
            this.focus(this._current,!this._dofull);
         } else {
            _local2 = param1.indexOf("_") + 1;
            if(_local2 > 0) {
               _local4 = "";
               _local5 = param1.indexOf("_",_local2);
               if(_local5 > 0) {
                  _local3 = uint(param1.substring(_local2,_local5));
                  _local4 = param1.substring(_local5 + 1);
               } else {
                  _local3 = uint(param1.substring(_local2));
               }
               _local6 = this.getRefById(_local3);
               if(_local4) {
                  _local6 = _local6[_local4];
               }
               if(_local6) {
                  if(param1.indexOf("refe_") == 0) {
                     console.explodech(console.panels.mainPanel.reportChannel,_local6);
                  } else {
                     this.focus(_local6,this._dofull);
                  }
                  return;
               }
            }
            report("Reference no longer exist (garbage collected).",-2);
         }
      }

      public function focus(param1:*, param2:Boolean = false) : void {
         remoter.send("focus");
         console.clear(LogReferences.INSPECTING_CHANNEL);
         console.setViewingChannels(LogReferences.INSPECTING_CHANNEL);
         if(!this._history) {
            this._history = new Array();
         }
         if(this._current != param1) {
            this._current = param1;
            if(this._history.length <= this._hisIndex) {
               this._history.push(param1);
            } else {
               this._history[this._hisIndex] = param1;
            }
            this._hisIndex++;
         }
         this._dofull = param2;
         this.inspect(param1,this._dofull);
      }

      private function handleFocused() : void {
         console.clear(LogReferences.INSPECTING_CHANNEL);
         console.setViewingChannels(LogReferences.INSPECTING_CHANNEL);
      }

      public function exitFocus() : void {
         var _local1:ByteArray = null;
         this._current = null;
         this._dofull = false;
         this._history = null;
         this._hisIndex = 0;
         if(remoter.remoting == Remoting.SENDER) {
            _local1 = new ByteArray();
            _local1.writeUTF("refexit");
            remoter.send("ref",_local1);
         }
         console.clear(LogReferences.INSPECTING_CHANNEL);
      }

      public function inspect(param1:*, param2:Boolean = true, param3:String = null) : void {
         var menuStr:String = null;
         var nodes:XMLList = null;
         var constantX:XML = null;
         var hasstuff:Boolean = false;
         var isstatic:Boolean = false;
         var methodX:XML = null;
         var accessorX:XML = null;
         var variableX:XML = null;
         var extendX:XML = null;
         var implementX:XML = null;
         var metadataX:XML = null;
         var mn:XMLList = null;
         var en:String = null;
         var et:String = null;
         var disp:DisplayObject = null;
         var theParent:DisplayObjectContainer = null;
         var pr:DisplayObjectContainer = null;
         var indstr:String = null;
         var cont:DisplayObjectContainer = null;
         var clen:int = 0;
         var ci:int = 0;
         var child:DisplayObject = null;
         var params:Array = null;
         var mparamsList:XMLList = null;
         var paraX:XML = null;
         var access:String = null;
         var X:* = undefined;
         var obj:* = param1;
         var viewAll:Boolean = param2;
         var ch:String = param3;
         if(!obj) {
            report(obj,-2,true,ch);
            return;
         }
         var refIndex:uint = this.setLogRef(obj);
         var showInherit:String = "";
         if(!viewAll) {
            showInherit = " [<a href=\'event:refi\'>show inherited</a>]";
         }
         if(this._history) {
            menuStr = "<b>[<a href=\'event:refexit\'>exit</a>]";
            if(this._hisIndex > 1) {
               menuStr = menuStr + " [<a href=\'event:refprev\'>previous</a>]";
            }
            if(Boolean(this._history) && this._hisIndex < this._history.length) {
               menuStr = menuStr + " [<a href=\'event:reffwd\'>forward</a>]";
            }
            menuStr = menuStr + ("</b> || [<a href=\'event:ref_" + refIndex + "\'>refresh</a>]");
            menuStr = menuStr + ("</b> [<a href=\'event:refe_" + refIndex + "\'>explode</a>]");
            if(config.commandLineAllowed) {
               menuStr = menuStr + (" [<a href=\'event:cl_" + refIndex + "\'>scope</a>]");
            }
            if(viewAll) {
               menuStr = menuStr + " [<a href=\'event:refi\'>hide inherited</a>]";
            } else {
               menuStr = menuStr + showInherit;
            }
            report(menuStr,-1,true,ch);
            report("",1,true,ch);
         }
         var V:XML = describeType(obj);
         var cls:Object = obj is Class?obj:obj.constructor;
         var clsV:XML = describeType(cls);
         var self:String = V.@name;
         var isClass:Boolean = obj is Class;
         var st:String = !!isClass?"*":"";
         var str:String = "<b>{" + st + this.genLinkString(obj,null,EscHTML(self)) + st + "}</b>";
         var props:Array = [];
         if(V.@isStatic == "true") {
            props.push("<b>static</b>");
         }
         if(V.@isDynamic == "true") {
            props.push("dynamic");
         }
         if(V.@isFinal == "true") {
            props.push("final");
         }
         if(props.length > 0) {
            str = str + (" <p-1>" + props.join(" | ") + "</p-1>");
         }
         report(str,-2,true,ch);
         nodes = V.extendsClass;
         if(nodes.length()) {
            props = [];
            for each(extendX in nodes) {
               st = extendX.@type.toString();
               props.push(st.indexOf("*") < 0?this.makeValue(getDefinitionByName(st)):EscHTML(st));
               if(!viewAll) {
                  break;
               }
            }
            report("<p10>Extends:</p10> " + props.join(" &gt; "),1,true,ch);
         }
         nodes = V.implementsInterface;
         if(nodes.length()) {
            props = [];
            for each(implementX in nodes) {
               props.push(this.makeValue(getDefinitionByName(implementX.@type.toString())));
            }
            report("<p10>Implements:</p10> " + props.join(", "),1,true,ch);
         }
         report("",1,true,ch);
         props = [];
         nodes = V.metadata.(@name == "Event");
         if(nodes.length()) {
            for each(metadataX in nodes) {
               mn = metadataX.arg;
               en = mn.(@key == "name").@value;
               et = mn.(@key == "MsgType").@value;
               if(refIndex) {
                  props.push("<a href=\'event:cl_" + refIndex + "_dispatchEvent(new " + et + "(\"" + en + "\"))\'>" + en + "</a><p0>(" + et + ")</p0>");
               } else {
                  props.push(en + "<p0>(" + et + ")</p0>");
               }
            }
            report("<p10>Events:</p10> " + props.join("<p-1>; </p-1>"),1,true,ch);
            report("",1,true,ch);
         }
         if(obj is DisplayObject) {
            disp = obj as DisplayObject;
            theParent = disp.parent;
            if(theParent) {
               props = new Array("@" + theParent.getChildIndex(disp));
               while(theParent) {
                  pr = theParent;
                  theParent = theParent.parent;
                  indstr = !!theParent?"@" + theParent.getChildIndex(pr):"";
                  props.push("<b>" + pr.name + "</b>" + indstr + this.makeValue(pr));
               }
               report("<p10>Parents:</p10> " + props.join("<p-1> -> </p-1>") + "<br/>",1,true,ch);
            }
         }
         if(obj is DisplayObjectContainer) {
            props = [];
            cont = obj as DisplayObjectContainer;
            clen = cont.numChildren;
            ci = 0;
            while(ci < clen) {
               child = cont.getChildAt(ci);
               props.push("<b>" + child.name + "</b>@" + ci + this.makeValue(child));
               ci++;
            }
            if(clen) {
               report("<p10>Children:</p10> " + props.join("<p-1>; </p-1>") + "<br/>",1,true,ch);
            }
         }
         props = [];
         nodes = clsV..constant;
         for each(constantX in nodes) {
            report(" const <p3>" + constantX.@name + "</p3>:" + constantX.@type + " = " + this.makeValue(cls,constantX.@name.toString()) + "</p0>",1,true,ch);
         }
         if(nodes.length()) {
            report("",1,true,ch);
         }
         var inherit:uint = 0;
         props = [];
         nodes = clsV..method;
         for each(methodX in nodes) {
            if(Boolean(viewAll) || self == methodX.@declaredBy) {
               hasstuff = true;
               isstatic = methodX.parent().name() != "factory";
               str = " " + (!!isstatic?"static ":"") + "function ";
               params = [];
               mparamsList = methodX.parameter;
               for each(paraX in mparamsList) {
                  params.push(paraX.@optional == "true"?"<i>" + paraX.@type + "</i>":paraX.@type);
               }
               if(Boolean(refIndex) && (Boolean(isstatic) || !isClass)) {
                  str = str + ("<a href=\'event:cl_" + refIndex + "_" + methodX.@name + "()\'><p3>" + methodX.@name + "</p3></a>");
               } else {
                  str = str + ("<p3>" + methodX.@name + "</p3>");
               }
               str = str + ("(" + params.join(", ") + "):" + methodX.@returnType);
               report(str,1,true,ch);
            } else {
               inherit++;
            }
         }
         if(inherit) {
            report("   \t + " + inherit + " inherited methods." + showInherit,1,true,ch);
         } else if(hasstuff) {
            report("",1,true,ch);
         }
         hasstuff = false;
         inherit = 0;
         props = [];
         nodes = clsV..accessor;
         for each(accessorX in nodes) {
            if(Boolean(viewAll) || self == accessorX.@declaredBy) {
               hasstuff = true;
               isstatic = accessorX.parent().name() != "factory";
               str = " ";
               if(isstatic) {
                  str = str + "static ";
               }
               access = accessorX.@access;
               if(access == "readonly") {
                  str = str + "get";
               } else if(access == "writeonly") {
                  str = str + "set";
               } else {
                  str = str + "assign";
               }
               if(Boolean(refIndex) && (Boolean(isstatic) || !isClass)) {
                  str = str + (" <a href=\'event:cl_" + refIndex + "_" + accessorX.@name + "\'><p3>" + accessorX.@name + "</p3></a>:" + accessorX.@type);
               } else {
                  str = str + (" <p3>" + accessorX.@name + "</p3>:" + accessorX.@type);
               }
               if(access != "writeonly" && (Boolean(isstatic) || !isClass)) {
                  str = str + (" = " + this.makeValue(!!isstatic?cls:obj,accessorX.@name.toString()));
               }
               report(str,1,true,ch);
            } else {
               inherit++;
            }
         }
         if(inherit) {
            report("   \t + " + inherit + " inherited accessors." + showInherit,1,true,ch);
         } else if(hasstuff) {
            report("",1,true,ch);
         }
         nodes = clsV..variable;
         for each(variableX in nodes) {
            isstatic = variableX.parent().name() != "factory";
            str = !!isstatic?" static":"";
            if(refIndex) {
               str = str + (" var <p3><a href=\'event:cl_" + refIndex + "_" + variableX.@name + " = \'>" + variableX.@name + "</a>");
            } else {
               str = str + (" var <p3>" + variableX.@name);
            }
            str = str + ("</p3>:" + variableX.@type + " = " + this.makeValue(!!isstatic?cls:obj,variableX.@name.toString()));
            report(str,1,true,ch);
         }
         try {
            props = [];
            for(X in obj) {
               if(X is String) {
                  if(refIndex) {
                     str = "<a href=\'event:cl_" + refIndex + "_" + X + " = \'>" + X + "</a>";
                  } else {
                     str = X;
                  }
                  report(" dynamic var <p3>" + str + "</p3> = " + this.makeValue(obj,X),1,true,ch);
               } else {
                  report(" dictionary <p3>" + this.makeValue(X) + "</p3> = " + this.makeValue(obj,X),1,true,ch);
               }
            }
         }
         catch(e:Error) {
            report("Could not get dynamic values. " + e.message,9,false,ch);
         }
         if(obj is String) {
            report("",1,true,ch);
            report("String",10,true,ch);
            report(EscHTML(obj),1,true,ch);
         } else if(obj is XML || obj is XMLList) {
            report("",1,true,ch);
            report("XMLString",10,true,ch);
            report(EscHTML(obj.toXMLString()),1,true,ch);
         }
         if(menuStr) {
            report("",1,true,ch);
            report(menuStr,-1,true,ch);
         }
      }

      public function getPossibleCalls(param1:*) : Array {
         var _local5:XML = null;
         var _local6:XML = null;
         var _local7:XML = null;
         var _local8:Array = null;
         var _local9:XMLList = null;
         var _local10:XML = null;
         var _local2:Array = new Array();
         var _local3:XML = describeType(param1);
         var _local4:XMLList = _local3.method;
         for each(_local5 in _local4) {
            _local8 = [];
            _local9 = _local5.parameter;
            for each(_local10 in _local9) {
               _local8.push(_local10.@optional == "true"?"<i>" + _local10.@type + "</i>":_local10.@type);
            }
            _local2.push([_local5.@name + "(",_local8.join(", ") + " ):" + _local5.@returnType]);
         }
         _local4 = _local3.accessor;
         for each(_local6 in _local4) {
            _local2.push([String(_local6.@name),String(_local6.@type)]);
         }
         _local4 = _local3.variable;
         for each(_local7 in _local4) {
            _local2.push([String(_local7.@name),String(_local7.@type)]);
         }
         return _local2;
      }

      private function makeValue(param1:*, param2:* = null) : String {
         return this.makeString(param1,param2,false,!!config.useObjectLinking?100:-1);
      }
   }
}
