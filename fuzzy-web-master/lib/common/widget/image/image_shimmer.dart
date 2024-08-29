import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ImageShimmer extends StatelessWidget {
  final String? url;
  final BoxShape? shape;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final BorderRadiusGeometry? radius;
  final Widget Function(BuildContext, String, dynamic)? errorWidget;
  const ImageShimmer({super.key, this.url, this.shape, this.height, this.width, this.fit, this.radius, this.errorWidget});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: shape == BoxShape.circle ? BorderRadius.circular(1000) : radius ?? BorderRadius.circular(5),
      child: Container(
        height: height ?? double.maxFinite,
        width: width ?? double.maxFinite,
        decoration: BoxDecoration(shape: shape ?? BoxShape.rectangle),
        child: CachedNetworkImage(
          imageUrl: url ?? '',
          fit: fit ?? BoxFit.cover,
          httpHeaders: const {
            'Accept': 'image/webp,image/*,*/*;q=0.8',
            'Access-Control-Allow-Origin': '*',
          },
          placeholder: (context, url) {
            return const Skeletonizer(
                enabled: true,
                effect: ShimmerEffect(duration: Duration(milliseconds: 500)),
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: Icon(
                    Icons.image_search,
                  ),
                )
                //Image.asset(AppAssets.sampleSideImage, fit: BoxFit.cover),
                );
          },
          errorWidget: errorWidget ??
              (context, url, error) {
                return Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: shape ?? BoxShape.rectangle,
                  ),
                  child: Icon(
                    shape == BoxShape.circle ? Icons.person : Icons.broken_image,
                    size: width ?? height ?? double.infinity,
                    color: Colors.grey[300],
                  ),
                );
              },
        ),
      ),
    );
  }
}
