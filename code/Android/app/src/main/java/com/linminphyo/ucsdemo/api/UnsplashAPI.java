package com.linminphyo.ucsdemo.api;

import com.linminphyo.ucsdemo.model.PhotoPOJO;
import java.util.List;
import retrofit2.Call;
import retrofit2.Retrofit;
import retrofit2.converter.gson.GsonConverterFactory;

/**
 * Created by lin on 5/21/17.
 */

public class UnsplashAPI {

  UnsplashService service;

  public UnsplashAPI() {

    Retrofit retrofit = new Retrofit.Builder().baseUrl("https://api.unsplash.com/")
        .addConverterFactory(GsonConverterFactory.create())
        .build();

    service = retrofit.create(UnsplashService.class);
  }

  public Call<List<PhotoPOJO>> getPhotos() {
    return service.listPhotos("Client-ID 10619883ac2617f21187d7008143bf0612cfcbb7ca6edacd4545371100e04012");
  }
}
