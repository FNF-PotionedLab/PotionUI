package potion.ui;

import flixel.FlxG;
import flixel.FlxCamera;
import flixel.group.FlxGroup;
import flixel.graphics.FlxGraphic;

/**
 * The core class for PotionUI.
 */
@:access
class UICore {
    /**
     * Whether or not PotionUI was initialized.
     */
    public static var initialized(default, null):Bool = false;

    /**
     * Initializes some necessary components for PotionUI.
     */
    public static function init():Void {
        if(initialized) {
            FlxG.log.warn("PotionUI was already initialized!");
            return;
        }
        initialized = true;
        _frontGroup = new FlxGroup();

        _frontCamera = new FlxCamera();
        _frontCamera.bgColor = 0;
        FlxG.cameras.add(_frontCamera);

        FlxG.signals.postStateSwitch.add(() -> {
            if(_frontCamera != null && FlxG.cameras.list.contains(_frontCamera))
                FlxG.cameras.remove(_frontCamera);

            for(obj in _frontGroup.members) {
                if(obj != null)
                    obj.destroy();
            }
            _frontGroup.clear();
            
            _frontCamera = new FlxCamera();
            _frontCamera.bgColor = 0;
            FlxG.cameras.add(_frontCamera);

            _frontGroup.cameras = [_frontCamera];
        });
        FlxG.signals.postUpdate.add(() -> {
            _frontGroup.update(FlxG.elapsed);
        });
        FlxG.signals.postDraw.add(() -> {
            _frontGroup.draw();
        });
        FlxG.log.add("PotionUI initialized successfully!");

        #if !POTIONED_FRAMEWORK
        FlxG.log.add("You aren't running PotionUI on Funkin Potioned, some features may be missing or behave differently!");
        #end
    }

    /**
     * Returns a graphic from a given UI component type.
     * 
     * @param  type  The UI component type to return a graphic from.
     */
    public static function getGraphic(type:UIComponentType):FlxGraphic {
        final graph:FlxGraphic = _cachedGraphics.get(type);
        if(graph == null) {
            FlxG.log.warn('A graphic for ${type} doesn\'t exist!');
            return null;
        }
        return graph;
    }

    // --------------- //
    // [ Private API ] //
    // --------------- //

    private static var _cachedGraphics:Map<UIComponentType, FlxGraphic> = [];

    private static var _frontGroup:FlxGroup;
    private static var _frontCamera:FlxCamera;
}