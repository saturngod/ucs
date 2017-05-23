package com.linminphyo.ucsdemo;

import android.content.Context;
import android.support.v7.widget.RecyclerView;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;
import com.linminphyo.ucsdemo.callback.OnPhotoItemClickListener;
import com.linminphyo.ucsdemo.model.PhotoPOJO;
import com.squareup.picasso.Picasso;

/**
 * Created by lin on 5/21/17.
 */

class PhotosViewHolder extends RecyclerView.ViewHolder implements View.OnClickListener {
  TextView tvName;
  ImageView ivPhoto;
  PhotoPOJO photoPOJO;
  View view ;

  OnPhotoItemClickListener itemClickListener;

  public PhotosViewHolder(View view , Context context) {
    super(view);
    this.view = view ;
    tvName = (TextView) view.findViewById(R.id.tv_name);
    ivPhoto = (ImageView) view.findViewById(R.id.tv_photo);

    itemClickListener = (OnPhotoItemClickListener) context;
    view.setOnClickListener(this);
  }

  public void bind(PhotoPOJO photoPOJO) {
    this.photoPOJO = photoPOJO ;
    tvName.setText(photoPOJO.getUser().getName());
    Picasso.with(view.getContext()).load(photoPOJO.getUrl().getSmall()).into(ivPhoto);
  }

  @Override public void onClick(View view) {
    itemClickListener.onPhotoItemClicked(photoPOJO);
  }
}
