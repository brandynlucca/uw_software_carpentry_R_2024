# Creating plots via `ggplot2`
# [̲̅$̲̅(ツ)$̲̅]
library(gapminder)
library(ggplot2)

#
ggplot(data = gapminder,
       mapping = aes(x = gdpPercap, y = lifeExp)) +
  geom_point()

ggplot(data = gapminder,
       mapping = aes(x = year, y = lifeExp, 
                     group = country)) +
  geom_point() +
  geom_line(mapping = aes(color = continent))

# Transformations
ggplot(data = gapminder,
       mapping = aes(x = gdpPercap, y = lifeExp)) +
  geom_point(alpha = 0.50,
             color = "orange",
             fill = "red",
             size = 3,
             shape = 25) +
  scale_x_log10() +
  annotation_logticks(base=10, side="b") +
  geom_smooth(method = "lm", linewidth=1.5) +
  theme_bw() +
  theme(panel.grid = element_blank(),
        text = element_text(size=20),
        axis.text = element_text(size=15, angle=45))

# --- shape options
?pch
# ---- theme options
?theme
# ---- pre-generated themes
# example
?theme_bw

# multipanel
ggplot(data = gapminder,
       mapping = aes(x = year, y = lifeExp, 
                     group = country)) +
  geom_point() +
  geom_line(mapping = aes(color = continent)) +
  facet_wrap(~ continent)

ggplot(data = gapminder[gapminder$continent == "Europe", ],
       mapping = aes(x = year, y = lifeExp, 
                     group = country)) +
  geom_point(mapping = aes(color = continent)) +
  geom_line() +
  facet_wrap(~ country) +
  theme_bw() +
  theme(panel.grid = element_blank(),
        text = element_text(size=15),
        axis.text.x = element_text(angle=90, hjust=1)) +
  labs(
    x = "Year",
    y = "Life expectancy (units)",
    title = NULL,
    color = "Continent"
  ) -> lifeexp_plot

# saving our plot
ggsave(filename = "C:/Users/Brandyn/Documents/lifeExp.png",
       plot = lifeexp_plot, 
       units = "cm",
       width = 12, 
       height = 10, 
       dpi = 96)

# ---- Boxplot
ggplot(data = gapminder, 
       mapping = aes(x = continent,
                     y = lifeExp,
                     fill = continent)) +
  geom_boxplot() +
  facet_wrap(~ year) +
  labs(y = "Life exptectancy (years)",
       fill = NULL) +
  theme_bw() +
  theme(axis.title.x = element_blank(),
        axis.text.x = element_blank(),
        axis.ticks.x = element_blank())
