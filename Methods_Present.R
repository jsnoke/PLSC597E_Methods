install.packages("igraph")
library(igraph) ## Necessary library - must download


#####
## igraph data objects
#####

install.packages("igraphdata")
library(igraphdata) ## igraph datasets here if interested

data("karate") ## loading a data set we will use. same data saved and uploaded to Angel
class(karate) ## igraph object - containing list of edges, nodes, and any information for edges and nodes

karate ## object overview. letters in paranthesis denote whether attributes are general, edges, or vertices (node)

karate$name ## general attributes are in the main list
E(karate) ## access edge information list
V(karate) ## access node information list


?as_data_frame ## igraph objects are changeable to data_frames using this function
test = as_data_frame(karate, what = c("both")) ## can extract edges, vertices, or both
class(test) ## data_frame or list of two data_frames
head(test$edges)
head(test$vertices)

?graph_from_data_frame ## to go the other direction - change data_frames to an igraph object

#######
## Karate club example
## Citation: W. W. Zachary, An information flow model for conflict and fission in small groups, Journal of Anthropological Research 33, 452-473 (1977).
#####

?layout_with_fr ## first function: define network graph as Fruchterman and Reingold layout
				## produces matrix with plotting coordinates to place each node

karateLayout = layout_with_fr( 
				karate,					## igraph object to be visualized
				coords = NULL, 				## optional starting positions for each node
				dim = 2, 				## 3D graphs are possible also. For this example I use 2D
				niter = 500, 				## number of iterations to run the F-R force-directed graph algorithm
				start.temp = sqrt(vcount(karate)), 	## starting point for 'temperature' - essentially how much the nodes will shift in each iteration
				grid = "auto", 				## option to use 'grid' method, which speeds up the computation time
			    						## default for 'auto' is to use grid with #nodes > 1000
				weights = E(karate)$weight, 		## edges weights: multipliers for the push and pull between nodes
				minx = NULL, 				## optional coordinate boundaries for the nodes 
				maxx = NULL, 				## see above
				miny = NULL, 				## see above
				maxy = NULL, 				## see above
				minz = NULL, 				## see above
				maxz = NULL				## see above
				#coolexp, 				## the last five arguments still show up in the code, but are no longer supported or necessary
				#maxdelta, 
				#area, 
				#repulserad, 
				#maxiter
				)

head(karateLayout)

?plot.igraph ## after producing the layout, we plot the network using this function
	     ## as with all plots in R, there are numerous graphical parameters. Only those I specifically found important for this example are described below

plot(
	karate, 				## original igraph object
      	layout = karateLayout, 			## the layout produced by running the function above. For this package, alternative layout algorithms are available
      	vertex.size = 20, 			## size of the nodes graphed
      	rescale = FALSE,			## whether to scale the plot coordinates to the unit interval - does not alter shape of the graph
      	xlim = range(karateLayout[, 1]), 	## plot window x-axis length
      						## note that these limits are not set automatically as with normal R plots
      	ylim = range(karateLayout[, 2]), 	## see above
      	vertex.label.dist = 1.5, 		## location for the node label. 0 sets the label on the node, 1 directly above.
      	vertex.label.color = "black",		## label font color
      	vertex.label.cex = 1,			## label font size
      	vertex.color = V(karate)$group		## node fill color. Here it is based on groups given in the original data
     	)


axis(1)	## plot axis alongside the network if desired
axis(2)


#######
## Les Miserable example
## Citation: D. E. Knuth, The Stanford GraphBase: A Platform for Combinatorial Computing, Addison-Wesley, Reading, MA (1993).
#####

load("lesMisKnuth.RData")

lesMisLayout = layout_with_fr(lesMisKnuth, dim = 2, weights = E(lesMisKnuth)$weight)

plot(lesMisKnuth, layout = lesMisLayout, vertex.size = 20, edge.arrow.size = 0.2, rescale = F,
     xlim = range(lesMisLayout[, 1]), ylim = range(lesMisLayout[, 2]), vertex.label.dist = 1, 
     vertex.label.color = "blue", vertex.label.cex = 0.75, vertex.color = V(lesMisKnuth)$group)










