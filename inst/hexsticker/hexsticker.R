#' 
#' Create an Hexagonal Sticker for the Package
#' 

hexSticker::sticker(

  subplot  = here::here("inst", "hexsticker", "icon.png"),
  package  = "rcompendium",
  filename = here::here("man", "figures", "hexsticker.png"),
  dpi      = 600,
  
  p_size   = 6.0,         # Title
  u_size   = 1.2,         # URL
  p_family = "Aller_Rg",
  
  p_color  = "#722F26",   # Title
  h_fill   = "#B0987D",   # Background
  h_color  = "#722F26",   # Border
  u_color  = "#433625",   # URL
  
  p_x      = 1.00,        # Title
  p_y      = 0.65,        # Title
  s_x      = 1.00,        # Subplot
  s_y      = 1.25,        # Subplot
  
  s_width  = 0.50,        # Subplot
  
  url      = "https://frbcesab.github.io/rcompendium"
)
