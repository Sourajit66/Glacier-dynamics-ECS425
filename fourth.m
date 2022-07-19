
movie_obj = VideoWriter('TestMovie.avi');
open(movie_obj);
for K=3:14
  this_image = imread(sprintf('FIG%d.png',K));
  writeVideo(movie_obj, this_image);
end
close(movie_obj);