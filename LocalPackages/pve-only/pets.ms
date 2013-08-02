# _spawn_horse(@loc, @variant, @color, @pattern) -> entityID
#	Spawn the specified horse variant at the specified location.
#	If the variant, color or pattern are null or empty strings, they are chosen 
#	randomly. In the case of variant, the randomly chosen value will be
#	horse 7/8ths of the time and donkey 1/8th of the time. Mules will never
#	be selected randomly as they do not spawn in the wild.
#	Return the entity ID of the spawned horse.

proc(_spawn_horse, @loc, @variant, @color, @pattern, 
	@HORSE_COLORS = array(black, brown, chestnut, creamy, dark_brown, gray, white)
	@HORSE_PATTERNS = array(none, socks, whitefield, white_dots, black_dots)

	@variant = to_lower(@variant)
	@color = to_lower(@color)
	@pattern = to_lower(@pattern)
	
	if (@color != '' && ! array_contains(@HORSE_COLORS, @color)) {
		die(color(RED).@color.' is not a valid horse color.')	
	}
	if (@pattern != '' && ! array_contains(@HORSE_PATTERNS, @pattern)) {
		die(color(RED).@pattern.' is not a valid horse pattern.')	
	}
	
	if (is_null(@variant) || @variant == '') {
		@variant = if (rand(8) == 0, 'donkey', 'horse')
	}
	if (is_null(@color) || @color == '') {
		@color = @HORSE_COLORS[rand(array_size(@HORSE_COLORS))]
	}
	if (is_null(@pattern) || @pattern == '') {
		@pattern = @HORSE_PATTERNS[rand(array_size(@HORSE_PATTERNS))]
	}
	
	@type = 'horse:'.@variant
	if (@variant == 'horse') {
		@type = @type.'-'.@color.'-'.@pattern
	}
	return (spawn_mob(@type, 1, @loc)[0]);
)
