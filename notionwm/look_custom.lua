-- look_paper
-- tabs without borders

if not gr.select_engine("de") then
    return
end


-- Clear existing styles from memory.
de.reset()

local empty = "#212026"
local white = "#ffffff"
local foreground = "#4fa3db"
--local background = "#3e6178"
local background = "#0f3b54"

local fg_dim = "#0f3d5c"
local bg_dim = "#111b21"

local padding = 3
local tab_line = 2
decoration = {
  active = {
      background = foreground
    , foreground  = { default = bg_dim, selected = "black" }
  }
  , inactive = {
      background = bg_dim
      , foreground  = { default = "grey", selected = white }
      , sp = {
          background = bg_dim
          , foreground  = { default = "grey", selected = fg_dim }
      }
  }
  , preview = {
      background = bg_dim
      , foreground  = { default = "grey", selected = fg_dim }
  }
}

-- Base decoration
de.defstyle("*", {
                -- Gray background
                highlight_colour = "#eeeeee",
                shadow_colour = "#eeeeee",
                background_colour = empty,
                foreground_colour = "#9aa28b",
                shadow_pixels = 1,
                highlight_pixels = 3,
                padding_pixels = 1,
                spacing = 3,
                border_style = "elevated",

                text_align = "center",
    		font = "-*-helvetica-medium-r-normal-*-12-*-*-*-*-*-*-*",
})

de.defstyle("frame-tiled", {
                border_sides = "lr",
                border_style = "elevated",
                shadow_pixels = padding,
                highlight_pixels = padding,
                padding_pixels = 0,
                spacing = 0,
                highlight_colour = decoration.inactive.background,
                shadow_colour    = decoration.inactive.background,
                background_colour = empty,
		transparent_background = true,

                de.substyle("inactive-*-preview", {
                                background_colour = decoration.preview.background,
                                highlight_colour = decoration.preview.background,
                                shadow_colour    = decoration.preview.background,
                }),

                de.substyle("active", {
                              background_colour = decoration.active.background,
                              highlight_colour = decoration.active.background,
                              shadow_colour    = decoration.active.background,
                }),
                de.substyle("inactive-selected", {
                              highlight_colour = decoration.inactive.background,
                              shadow_colour    = decoration.inactive.background,
                })
})

de.defstyle("tab", {
    show_icon=true,
    font = "-*-helvetica-medium-r-normal-*-13-*-*-*-*-*-*-*",
    icon_align_left=false,
    border_sides="tb",
    border_style="elevated",
    shadow_pixels=tab_line,
    highlight_pixels=0,
    spacing = 3,

    shadow_colour = decoration.inactive.foreground.default,
    highlight_colour = decoration.inactive.foreground.default,
    background_colour = decoration.inactive.background,

    de.substyle("inactive-selected-preview", {
                    background_colour = decoration.preview.background,
                    shadow_colour = decoration.preview.foreground.selected,
                    foreground_colour = decoration.preview.foreground.selected,
    }),

    de.substyle("inactive-preview", {
                    background_colour = decoration.preview.background,
                    shadow_colour = decoration.preview.foreground.default,
                    foreground_colour = decoration.preview.foreground.default,
    }),

    de.substyle("active", {
        background_colour = decoration.active.background,
        shadow_colour = decoration.active.foreground.default,
        foreground_colour = decoration.active.foreground.default,
    }),

    de.substyle("active-selected", {
        background_colour = decoration.active.background,
        shadow_colour = decoration.active.foreground.selected,
        foreground_colour = decoration.active.foreground.selected,
    }),

    de.substyle("inactive-selected", {
        background_colour = decoration.inactive.background,
        shadow_colour = decoration.inactive.foreground.selected,
        foreground_colour = decoration.inactive.foreground.selected
    }),

    -- urgent hint style
    de.substyle("inactive-*-*-unselected-activity", {
                  shadow_colour = "#b03030",
                    background_colour = decoration.inactive.background,
                    foreground_colour = decoration.inactive.foreground.default,
}),
    de.substyle("inactive-*-*-selected-activity", {
                  shadow_colour = "#fe0f0f",
                  background_colour = decoration.inactive.background,
                  foreground_colour = decoration.inactive.foreground.selected,
    }),

    de.substyle("active-*-*-unselected-activity", {
                  shadow_colour = "#fe0f0f",
                  background_colour = decoration.active.background,
                  foreground_colour = decoration.active.foreground.default,
    }),
})

de.defstyle("tab-frame-floating", {
              border_style = "elevated",
              padding_pixels = 0,
              highlight_pixels = 0,
              shadow_pixels = 2,
              border_sides = "tb",
              spacing = 0
})


de.defstyle("input", {
  text_align = "left",
        font = "-*-helvetica-medium-r-normal-*-17-*-*-*-*-*-*-*",
  spacing = 0,
	border_style = "elevated",
	border_sides = "tb",
    -- Greyish violet background
    highlight_colour = "#9a9292",
    shadow_colour = "#000000",
    background_colour = "#101028",
    foreground_colour = "#ffffff",
    
    de.substyle("*-selection", {
        background_colour = "#9a9292",
        foreground_colour = "#000000",
    }),

    de.substyle("*-cursor", {
        background_colour = "#ffffff",
        foreground_colour = "#9999aa",
    }),
})

de.defstyle("tab-menuentry", {
                highlight_pixels = 0,
                shadow_pixels = 0,
                padding_pixels = 1,
                text_align = "left",
})

de.defstyle("tab-menuentry-big", {
                padding_pixels = 7,
                font = "-*-helvetica-medium-r-normal-*-17-*-*-*-*-*-*-*",
})


de.defstyle("actnotify", {
                shadow_colour = "#c04040",
                highlight_colour = "#c04040",
                background_colour = "#901010",
                foreground_colour = "#eeeeee",
})


de.defstyle("stdisp", {
                border_sides = "tb",
                border_style = "elevated",
                shadow_pixels = 0,
                highlight_pixels = 2,
                highlight_colour = decoration.inactive.foreground.default,
                text_align = "left",
                background_colour = empty,
                foreground_colour = "grey",
                font="-misc-fixed-medium-r-*-*-13-*-*-*-*-60-*-*",

                de.substyle("important", {
                                foreground_colour = "green",
                }),

                de.substyle("critical", {
                                foreground_colour = "red",
                }),
})

de.defstyle("frame-floating-alt", {
              bar = "none",
              border_sides = "all",
              -- padding_pixels = 2,
              highlight_pixels = 8,
              shadow_pixels = 8,
              highlight_colour =
                decoration.inactive.sp.foreground.default,
              shadow_colour =
                decoration.inactive.sp.foreground.default,
              highlight_colour = decoration.inactive.sp.background,
              shadow_colour    = decoration.inactive.sp.background,
})

de.defstyle("frame-unknown-alt", {
              bar = "none",
              border_sides = "all",
              spacing = 0,
              padding_pixels = 0,
              highlight_pixels = 0,
              shadow_pixels = 0
})

-- Refresh objects' brushes.
gr.refresh()
