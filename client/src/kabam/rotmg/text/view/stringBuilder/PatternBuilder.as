package kabam.rotmg.text.view.stringBuilder {
import kabam.rotmg.language.model.StringMap;

public class PatternBuilder implements StringBuilder {

      private const PATTERN:RegExp = new RegExp("(\\{([^\\{]+?)\\})","gi");

      private var pattern:String = "";

      private var keys:Array;

      private var provider:StringMap;

      public function PatternBuilder() {
         super();
      }

      public function setPattern(param1:String) : PatternBuilder {
         this.pattern = param1;
         return this;
      }

      public function setStringMap(param1:StringMap) : void {
         this.provider = param1;
      }

      public function getString() : String {
         var _local2:String = null;
         this.keys = this.pattern.match(this.PATTERN);
         var _local1:String = this.pattern;
         for each(_local2 in this.keys) {
            _local1 = _local1.replace(_local2,this.provider.getValue(_local2.substr(1,_local2.length - 2)));
         }
         return _local1.replace(new RegExp("\\\\n","g"),"\n");
      }
   }
}
