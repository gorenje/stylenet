# Stylenet

This is a Tensorflow project of neural network with the style synthesis algorithm modified from 2 major methods [Gram Matrix](http://arxiv.org/abs/1508.06576) and [Markov Random Fields](http://arxiv.org/abs/1601.04589). By given a content and style image, the style and pattern can be synthesised into the content. This project also support [region mapping](http://arxiv.org/abs/1603.01768). We have added several modifications in the Markov Random Fields cost functions. See belows for the detail.

The visual network is make use of the [Tensorflow VGG19 network](https://github.com/machrisaa/tensorflow-vgg) (Original Caffe implementation is in [here](https://gist.github.com/ksimonyan/211839e770f7b538e2d8) and [here](https://gist.github.com/ksimonyan/3785162f95cd2d5fee77)).

Here are some sample result generated by this algorithm.

Basic synthesis
<table>
  <tr>
    <td><img src="https://github.com/machrisaa/stylenet/blob/master/images/cat-water-colour.jpg"/></td>
    <td><img src="https://github.com/machrisaa/stylenet/blob/master/images/cat_h.jpg"/></td>
    <td><img src="https://github.com/machrisaa/stylenet/blob/master/images/cat-result.jpeg"/></td>
  </tr>
  <tr>
    <td align='center'>Content</td>
    <td align='center'>Style</td>
    <td align='center'>Result</td>
  </tr>
</table>
>See the intermediate results in [this video](https://youtu.be/4ssJyLivbBM)

<br/>
Synthesis with region mapping
<table>
  <tr>
    <td><img src="https://github.com/machrisaa/stylenet/blob/master/images/husky_paint.jpg"/></td>
    <td><img src="https://github.com/machrisaa/stylenet/blob/master/images/husky_real.jpg"/></td>
    <td rowspan=3><img src="https://github.com/machrisaa/stylenet/blob/master/images/husky-result.jpg"/></td>
  </tr>
  <tr>
    <td align='center'>Content</td>
    <td align='center'>Style</td>
  </tr>
  <tr>
    <td><img src="https://github.com/machrisaa/stylenet/blob/master/images/husky_paint_region.jpg"/></td>
    <td><img src="https://github.com/machrisaa/stylenet/blob/master/images/husky_real_region.jpg"/></td>
  </tr>
  <tr>
    <td align='center'>Content Region Map</td>
    <td align='center'>Style Region Map</td>
    <td align='center'>Result</td>
  </tr>
</table>
<br/>
<br/>

## Modification of Algorithm
<img src="https://github.com/machrisaa/stylenet/blob/master/images/stylenet_patch_diagram.png"/>
There are 2 modifications of the algorithm from the original Markov Random Field in the paper.

- We added the blur filtering in the convariant matrix before calculate the max argument in order to reduce the different of the convariant score in a local neighbouthood. This can make the result image look more natural. (Yellow part in the diagram)

- The second modification is to replace the cost function of the piecwise square difference between all patches and the slices of the image. We replaced the function to a single averaged patch tensor in order greatly improve the training process. (Red part in the diagram)
<br/>
<br/>

## Requirement
- [Tensorflow](https://www.tensorflow.org/versions/r0.7/get_started/index.html)
- [Tensorflow-VGG](https://github.com/machrisaa/tensorflow-vgg)
<br/>
<br/>

## Basic Usage
```
stylenet_patch.render_gen( <content image path> , <style image path>, height=<output height>)
```
See the smaple main function in [stylenet_patch](https://github.com/machrisaa/stylenet/blob/master/stylenet_patch.py) for more detail.

## Dockerfile

This can be used to test stylenet in an encapsulated environment.

First download the *.npy files as described above and dump them here in the
directory.

Then create a local docker image:

    docker build -t stylenet .

This will copy everything here in the directory to the image.

Start the image:

    docker run --privileged -it stylenet:latest /bin/bash

You'll need to start it in privileged mode since you'll need to add swap
memory to the running system. So in the running system, do the following:


    dd if=/dev/zero of=/swapfile bs=4k count=2048k
    chmod 600 /swapfile
    mkswap /swapfile
    swapon /swapfile

So if you have enough memory and cpus for your docker container (in my
case 8 cpus and 12G memory), then you can start the training:

    python stylenet_patch.py

This might be killed after the first generation, then just restart. It will
continue on the next generation. Any failure before the generation is complete
means that you'll need to increase memory and/or cpus.

Good Luck!
