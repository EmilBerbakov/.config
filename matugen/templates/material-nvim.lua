return {
	-- Backgrounds
	base00 = '{{colors.surface.default.hex}}',            -- Default Background
	base01 = '{{colors.surface_container.default.hex}}',  -- Lighter Background (Status bar)
	base02 = '{{colors.surface_container_highest.default.hex}}', -- Selection Background

	-- Foregrounds and Comments
	base03 = '{{colors.outline.default.hex}}',     -- Comments, Invisibles
	base04 = '{{colors.on_surface_variant.default.hex}}', -- Dark Foreground
	base05 = '{{colors.on_surface.default.hex}}',  -- Default Foreground
	base06 = '{{colors.inverse_surface.default.hex}}', -- Light Foreground
	base07 = '{{colors.inverse_on_surface.default.hex}}', -- Light Background

	-- Accents mapped to syntax highlighting
	base08 = '{{colors.error.default.hex}}',       -- Variables, XML Tags (Typically Red)
	base09 = '{{colors.tertiary_fixed_dim.default.hex}}', -- Integers, Constants (Typically Orange)
	base0A = '{{colors.tertiary.default.hex}}',    -- Classes, Search Text (Typically Yellow)
	base0B = '{{colors.primary.default.hex}}',     -- Strings, Markup Code (Typically Green)
	base0C = '{{colors.inverse_primary.default.hex}}', -- Regular Expressions (Typically Cyan)
	base0D = '{{colors.primary.default.hex}}',     -- Functions, Methods (Typically Blue)
	base0E = '{{colors.secondary.default.hex}}',   -- Keywords, Storage (Typically Purple)
	base0F = '{{colors.outline_variant.default.hex}}', -- Deprecated (Typically Brown/Dark Red)
}
