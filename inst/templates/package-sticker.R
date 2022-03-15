#'
#' Create an Hexagonal Sticker for the Package
#'


# install.packages(c("png", "ggplot2", "hexSticker", "grid", "ggpubr"))


rlogo <- png::readPNG(here::here("inst", "package-sticker", "r_logo.png"))
rlogo <- grid::rasterGrob(rlogo, interpolate = TRUE)

p <- ggplot2::ggplot() +
  ggplot2::annotation_custom(rlogo, xmin = -Inf, xmax = Inf, ymin = -Inf, 
                             ymax = Inf) +
  ggplot2::theme_void() +
  ggpubr::theme_transparent()

hexSticker::sticker(

  subplot   = p,
  package   = "R Package",
  filename  = here::here("man", "figures", "package-sticker.png"),
  dpi       = 600,

  p_size    = 28.0,         # Title
  u_size    =  5.0,         # URL
  p_family  = "Aller_Rg",

  p_color   = "#32436F",   # Title
  h_fill    = "#FFFFFF",   # Background
  h_color   = "#1064B2",   # Border
  u_color   = "#32436F",   # URL

  p_x       = 1.00,        # Title
  p_y       = 0.60,        # Title
  s_x       = 1.00,        # Subplot
  s_y       = 1.25,        # Subplot

  s_width   = 1.25,        # Subplot
  s_height  = 1.25,        # Subplot

  url       = "https://github.com/",

  spotlight = TRUE,
  l_alpha   = 0.10,
  l_width   = 4,
  l_height  = 4
)
