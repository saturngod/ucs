package com.linminphyo.ucsdemo.activities;

import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.View;
import android.widget.ProgressBar;
import android.widget.Toast;
import com.linminphyo.ucsdemo.PhotosAdapter;
import com.linminphyo.ucsdemo.R;
import com.linminphyo.ucsdemo.api.UnsplashAPI;
import com.linminphyo.ucsdemo.callback.OnPhotoItemClickListener;
import com.linminphyo.ucsdemo.model.PhotoPOJO;
import java.util.ArrayList;
import java.util.List;
import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class MainActivity extends AppCompatActivity implements OnPhotoItemClickListener {

  RecyclerView rvPhotos;
  ProgressBar progressBar;

  List<PhotoPOJO> photos = new ArrayList<>();
  PhotosAdapter photosAdapter;

  @Override protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    setContentView(R.layout.activity_main);

    rvPhotos = (RecyclerView) findViewById(R.id.rv_photos);
    progressBar = (ProgressBar) findViewById(R.id.progressbar);

    photosAdapter = new PhotosAdapter(photos, this);
    rvPhotos.setAdapter(photosAdapter);
    rvPhotos.setLayoutManager(new LinearLayoutManager(this));

    fetchFromAPI();

  }

  private void fetchFromAPI() {
    UnsplashAPI unsplashAPI = new UnsplashAPI();
    unsplashAPI.getPhotos().enqueue(new Callback<List<PhotoPOJO>>() {
      @Override
      public void onResponse(Call<List<PhotoPOJO>> call, Response<List<PhotoPOJO>> response) {
        photos.addAll(response.body());
        photosAdapter.notifyDataSetChanged();
        progressBar.setVisibility(View.GONE);
      }

      @Override public void onFailure(Call<List<PhotoPOJO>> call, Throwable t) {
        Toast.makeText(getApplicationContext(), t.getMessage(), Toast.LENGTH_LONG).show();
        progressBar.setVisibility(View.GONE);
      }
    });
  }

  @Override public void onPhotoItemClicked(PhotoPOJO photo) {
    Intent intent = new Intent(this, PhotoDetailsActivity.class);
    intent.putExtra("photoPOJO", photo);
    startActivity(intent);
  }
}
