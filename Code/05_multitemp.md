# Reporting multitemporal analysis by Markdown

In order to perfor multitemporal analysis, datasets in different times can be imported, by:

 ```r
im.list()
gr = im.import("greenland")
```

Once the set has been imported we can calculate the differences between different dates, as:

``` r
grdif = gr[[1]] - gr[[4]]
```

the output will be something like:
