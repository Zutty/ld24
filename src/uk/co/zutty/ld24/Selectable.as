package uk.co.zutty.ld24
{
    public interface Selectable {
        function get selected():Boolean;
        function set selected(s:Boolean):void;
        function get faction():int;
        function get stance():int;
    }
}