#!/usr/bin/env Rscript

library(ggplot2)
library(argparse)
library(data.table)
library(ggquiver)


commandline_parser = ArgumentParser()
commandline_parser$add_argument("input_file")
commandline_parser$add_argument("output_file")

args = commandline_parser$parse_args()
width = 10
factor = 0.618
height = width * factor

dt = fread(args$input_file)
print(dt)

plot = ggplot(dt) +
    geom_quiver(aes(x=x, y=y, u=u, v=v, colour=a), vecsize=2) +
    xlab("") +
    ylab("") +
    scale_color_continuous(name="asymmetry") +
    theme(axis.line=element_blank(),
        axis.text.x=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks=element_blank(),
        axis.title.x=element_blank(),
        axis.title.y=element_blank())
print(plot)
ggsave(args$output_file, plot, width=width, height=height, dpi=300)
invisible(readLines("stdin", n=1))
