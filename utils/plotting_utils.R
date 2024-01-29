############################## GGPLOT ####################

# basic theme that can be added onto
theme_nice <- function(base_size = 14, base_family = "Arial") {
  
  out <- ggplot2::theme_light(base_size = base_size, base_family = base_family) +
    ggplot2::theme(
      plot.caption = ggplot2::element_text(vjust = 1, size = ggplot2::rel(0.7), color = "gray30", margin = ggplot2::margin(12, 0, 0, 0)),
      axis.ticks = ggplot2::element_blank(),
      panel.grid.major.x = ggplot2::element_blank(),
      panel.grid.major.y = ggplot2::element_line(colour = "gray85"),
      panel.grid.minor = ggplot2::element_blank(),
      axis.title = ggplot2::element_text(face = "bold", colour = "gray20", size = ggplot2::rel(0.8)),
      axis.text = ggplot2::element_text(color = "gray30", size = ggplot2::rel(0.8)),
      plot.title = ggtext::element_textbox_simple(face = "bold", colour = "gray10", size = ggplot2::rel(1.1)),
      plot.subtitle = ggplot2::element_text(color = "gray20"),
      plot.title.position = "plot",
      plot.caption.position = "panel",
      legend.title = ggplot2::element_text(size = ggplot2::rel(0.9)),
      legend.text = ggplot2::element_text(size = ggplot2::rel(0.75)),
      legend.key.width = grid::unit(1.1, "lines"),
      legend.key.height = grid::unit(0.8, "lines"),
      panel.background = ggplot2::element_rect(fill = "gray100"),
      panel.border = ggplot2::element_blank(),
      strip.background = ggplot2::element_rect(fill = "gray95"),
      strip.text = ggplot2::element_text(color = "gray20"))
  
  return(out)
}

# y scale to remove gap below bars
scale_y_barcontinuous <- function(...) {
  ggplot2::scale_y_continuous(expand = expansion(mult = c(0, 0.05)), ...)
}

############################## COLORS ####################
# set of qualitative colors
qual_pal <- rcartocolor::carto_pal(n = 12, "Bold")


############################## STRINGS ####################
dollar_k <- function(x, scale = 1e-3, accuracy = 1, suffix = "k", ...) {
  scales::label_dollar(scale = scale, accuracy = accuracy, suffix = suffix, ...)(x)
}
