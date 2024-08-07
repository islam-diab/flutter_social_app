part of '../add_post.dart';

class _PickedImages extends StatelessWidget {
  const _PickedImages();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AddNewPostCubit, AddNewPostState, List<String>>(
      selector: (state) => state.images,
      builder: (context, images) {
        if (images.isEmpty) {
          return Center(
            child: IconButton(
              onPressed: () {
                context.read<AddNewPostCubit>().pickImage();
              },
              icon: const Icon(Icons.add_a_photo_outlined),
            ),
          );
        }
        return GridView.builder(
          itemCount: images.length + 1,
          itemBuilder: (context, index) {
            return index == images.length
                ? Center(
                    child: IconButton(
                      onPressed: () {
                        context.read<AddNewPostCubit>().pickImage();
                      },
                      icon: const Icon(Icons.add_a_photo_outlined),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Image.file(File(images.elementAt(index))),
                  );
          },
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 100,
          ),
        );
      },
    );
  }
}
