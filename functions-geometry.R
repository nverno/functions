################################################################################
##
##                                 Geometry
##
################################################################################

################################################################################
##
##                               Solid angles
##
################################################################################

## http://en.wikipedia.org/wiki/Subtended_angle
## Solid angle subtended by circular cone of opening angle, theta
sr_cone <- function(theta, deg=FALSE) {
    if (deg) theta <- theta * pi/180
    2*pi*(1 - cos(theta/2))
}

## Solid angle for tetrahedron
## http://en.wikipedia.org/wiki/Solid_angle
## translated from python version
## a, b, and c are position vectors of triangle which subtends angle at origin
a = c(1, 0, 0)
b = c(0, 1, 0)
c = c(0, 0, 1)

theta <- atan(y / x)
theta[x < 0] <- theta[x < 0] + pi
theta[x >= 0 & y < 0] <- theta[x >= 0 & y < 0] + 2*pi

tri_projection <- function(a, b, c) {
    determ = det(rbind(a, b, c))
    al = norm(as.matrix(a), "f")
    bl = norm(as.matrix(b), "f")
    cl = norm(as.matrix(c), "f")

    div = al*bl*cl + crossprod(a, b)*cl + crossprod(a, c)*bl +
        crossprod(b, c)*al
    at = atan(determ, div)
    if (div < 0)
    ## if (at < 0)
    ##     at = at + 2*pi  # if det > 0 and div < 0 atan2 returns < 0, so add pi
    omega = 2 * at
    return ( omega )
}

## library(geometry)
## require(rgl)

## fd = function(p, ...) sqrt((p^2)%*%c(1,1,1)) - 1
##                                         # also predefined as `mesh.dsphere'
## fh = function(p,...)  rep(1,nrow(p))
##                                         # also predefined as `mesh.hunif'
## bbox = matrix(c(-1,1),2,3)
## p = distmeshnd(fd,fh,0.3,bbox, maxiter=100)
##                                         # this may take a while:
##                                         # press Esc to get result of current iteration
## End(Not run)