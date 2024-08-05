package potion.ui;

import flixel.FlxG;
import flixel.util.FlxTimer;

import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

import flixel.group.FlxSpriteGroup;

enum abstract UIToastIcon(Int) from Int to Int {
    final INFO = 0;
    final WARNING = 1;
    final ERROR = 2;
    final QUESTION = 3;
}

typedef UIToastButtonParams = {
    var text:String;
    var callback:UIToast->Void;
}

typedef UIToastParams = {
    var icon:UIToastIcon;
    var title:String;
    var description:String;
    var buttons:Array<UIToastButtonParams>;
}

@:access(potion.ui.UICore)
class UIToast extends FlxSpriteGroup {
    public function new(params:UIToastParams) {
        super();
        trace('Spawning a new UIToast with params:\n- Icon: ${params.icon}\n- Title: ${params.title}\n- Description: ${params.description}\n- Buttons: ${[for(b in params.buttons) b.text].join(", ")}');
    }
    
    public function showToast():Void {
        UICore._frontGroup.add(this);

        x = FlxG.width + 10;
        FlxTween.tween(this, {x: FlxG.width - width - 20}, 0.5, {ease: FlxEase.cubeOut});
        
        new FlxTimer().start(5, (_) -> closeToast());
    }

    public function closeToast():Void {
        alpha = 1;
        x = FlxG.width - width - 20;
        
        FlxTween.cancelTweensOf(this);
        FlxTween.tween(this, {x: FlxG.width + 10}, 0.5, {ease: FlxEase.cubeIn, onComplete: (_) -> {
            UICore._frontGroup.remove(this, true);
        }});
    }
}