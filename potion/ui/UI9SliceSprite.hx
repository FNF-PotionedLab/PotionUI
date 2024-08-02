package potion.ui;

import flixel.FlxG;
import flixel.FlxSprite;

import flixel.graphics.frames.FlxFrame;
import flixel.system.FlxAssets.FlxGraphicAsset;

import flixel.util.FlxAxes;

/**
 * A sprite built for displaying 9 scaled slices of a graphic.
 * 
 * @see https://github.com/FNF-CNE-Devs/CodenameEngine/blob/main/source/funkin/editors/ui/UISliceSprite.hx
 */
class UI9SliceSprite extends FlxSprite {
    public var boxWidth(default, null):Float = 0;
    public var boxHeight(default, null):Float = 0;

    public function loadAndSliceGraphic(graph:FlxGraphicAsset):UI9SliceSprite {
        loadGraphic(graph);
        loadGraphic(graphic, true, Std.int(graphic.width / 3), Std.int(graphic.height / 3));
        return this;
    }

    public function resizeBox(width:Float, height:Float):Void {
        boxWidth = width;
        boxHeight = height;
    }

    override function screenCenter(axes:FlxAxes = XY):UI9SliceSprite {
        if (axes.x)
            x = (FlxG.width - boxWidth) / 2;

        if (axes.y)
            y = (FlxG.height - boxHeight) / 2;

        return this;
    }

    override function draw():Void {
        if(graphic == null)
            return;

        _drawCorner(TOP_LEFT);
        _drawCorner(TOP);
        _drawCorner(TOP_RIGHT);

        _drawCorner(MIDDLE_LEFT);
        _drawCorner(MIDDLE);
        _drawCorner(MIDDLE_RIGHT);

        _drawCorner(BOTTOM_LEFT);
        _drawCorner(BOTTOM);
        _drawCorner(BOTTOM_RIGHT);
    }

    // --------------- //
    // [ Private API ] //
    // --------------- //

    private function _setSize(Width:Float, Height:Float) {
		setGraphicSize(Width, Height);
		updateHitbox();
	}

    private function _drawCorner(cornerType:SliceCorner):Void {
        final x:Float = this.x;
        final y:Float = this.y;

        final topLeft:FlxFrame = frames.frames[0];
        final top:FlxFrame = frames.frames[1];
        final topRight:FlxFrame = frames.frames[2];

        final middleLeft:FlxFrame = frames.frames[3];
        final middle:FlxFrame = frames.frames[4];
        final middleRight:FlxFrame = frames.frames[5];

        final bottomLeft:FlxFrame = frames.frames[6];
        final bottom:FlxFrame = frames.frames[7];
        final bottomRight:FlxFrame = frames.frames[8];

        final middleHeight:Float = boxHeight - (topLeft.frame.height * Math.min(boxHeight / (topLeft.frame.height * 2), 1)) - bottomLeft.frame.height * Math.min(boxHeight / (bottomLeft.frame.height * 2), 1);

        switch(cornerType) {
            case TOP_LEFT:
                frame = frames.frames[0];
                setPosition(x, y);
                _setSize(
					topLeft.frame.width * Math.min(boxWidth / (topLeft.frame.width * 2), 1),
					topLeft.frame.height * Math.min(boxHeight / (topLeft.frame.height * 2), 1)
				);
				super.draw();

            case TOP:
				if (boxWidth > topLeft.frame.width + topRight.frame.width) {
					frame = top;
					setPosition(x + topLeft.frame.width, y);
					_setSize(
                        boxWidth - topLeft.frame.width - topRight.frame.width,
                        top.frame.height * Math.min(boxHeight / (top.frame.height * 2), 1)
                    );
					super.draw();
				}

            case TOP_RIGHT:
                setPosition(x + boxWidth - (topRight.frame.width * Math.min(boxWidth / (topRight.frame.width * 2), 1)), y);
				frame = topRight;
				_setSize(
					topRight.frame.width * Math.min(boxWidth / (topRight.frame.width * 2), 1),
					topRight.frame.height * Math.min(boxHeight / (topRight.frame.height * 2), 1)
				);
				super.draw();

            case MIDDLE_LEFT:
                frame = middleLeft;
				setPosition(x, y + top.frame.height);
				_setSize(middleLeft.frame.width * Math.min(boxWidth / (middleLeft.frame.width * 2), 1), middleHeight);
				super.draw();

            case MIDDLE:
                if (boxWidth > (middleLeft.frame.width * Math.min(boxWidth / (middleLeft.frame.width * 2), 1)) + middleRight.frame.width) {
					frame = middle;
					setPosition(x + topLeft.frame.width, y + top.frame.height);
					_setSize(boxWidth - middleLeft.frame.width - middleRight.frame.width, middleHeight);
					super.draw();
				}

            case MIDDLE_RIGHT:
                frame = middleRight;
				setPosition(x + boxWidth - (topRight.frame.width * Math.min(boxWidth / (topRight.frame.width * 2), 1)), y + top.frame.height);
				_setSize(middleRight.frame.width * Math.min(boxWidth / (middleRight.frame.width * 2), 1), middleHeight);
				super.draw();

            case BOTTOM_LEFT:
                frame = bottomLeft;
				setPosition(x, y + boxHeight - (bottomLeft.frame.height * Math.min(boxHeight / (bottomLeft.frame.height * 2), 1)));
				_setSize(
					bottomLeft.frame.width * Math.min(boxWidth / (bottomLeft.frame.width * 2), 1),
					bottomLeft.frame.height * Math.min(boxHeight / (bottomLeft.frame.height * 2), 1)
				);
				super.draw();

            case BOTTOM:
                if (boxWidth > bottomLeft.frame.width + bottomRight.frame.width) {
					frame = bottom;
					setPosition(x + bottomLeft.frame.width, y + boxHeight - (bottom.frame.height * Math.min(boxHeight / (bottom.frame.height * 2), 1)));
					_setSize(boxWidth - bottomLeft.frame.width - bottomRight.frame.width, bottom.frame.height * Math.min(boxHeight / (bottom.frame.height * 2), 1));
					super.draw();
				}

            case BOTTOM_RIGHT:
                frame = bottomRight;
				setPosition(
					x + boxWidth - (bottomRight.frame.width * Math.min(boxWidth / (bottomRight.frame.width * 2), 1)),
					y + boxHeight - (bottomRight.frame.height * Math.min(boxHeight / (bottomRight.frame.height * 2), 1))
				);
				_setSize(
					bottomRight.frame.width * Math.min(boxWidth / (bottomRight.frame.width * 2), 1),
					bottomRight.frame.height * Math.min(boxHeight / (bottomRight.frame.height * 2), 1)
				);
				super.draw();
        }
        setPosition(x, y);
    }
}

enum SliceCorner {
    TOP_LEFT;
    TOP;
    TOP_RIGHT;

    MIDDLE_LEFT;
    MIDDLE;
    MIDDLE_RIGHT;

    BOTTOM_LEFT;
    BOTTOM;
    BOTTOM_RIGHT;
}