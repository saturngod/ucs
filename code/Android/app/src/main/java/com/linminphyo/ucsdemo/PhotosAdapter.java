package com.linminphyo.ucsdemo;

import android.content.Context;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import com.linminphyo.ucsdemo.model.PhotoPOJO;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by lin on 5/21/17.
 */

public class PhotosAdapter extends RecyclerView.Adapter<RecyclerView.ViewHolder> {

  private List<PhotoPOJO> photoList = new ArrayList<>();
  Context context;

  public PhotosAdapter(List<PhotoPOJO> photoList, Context context) {
    this.photoList = photoList;
    this.context = context ;
  }

  @Override public RecyclerView.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
    View view =
        LayoutInflater.from(parent.getContext()).inflate(R.layout.item_photo, parent, false);
    return new PhotosViewHolder(view , context);
  }

  @Override public void onBindViewHolder(RecyclerView.ViewHolder holder, int position) {
    ((PhotosViewHolder) holder).bind(photoList.get(position));
  }

  @Override public int getItemCount() {
    return photoList.size();
  }
}
