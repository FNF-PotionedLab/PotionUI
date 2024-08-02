package potion.ui;

import flixel.FlxG;
import flixel.graphics.FlxGraphic;

/**
 * The core class for PotionUI.
 */
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
}