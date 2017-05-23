package com.linminphyo.ucsdemo.api;

import com.linminphyo.ucsdemo.model.PhotoPOJO;
import java.util.List;
import retrofit2.Call;
import retrofit2.http.GET;
import retrofit2.http.Header;

/**
 * Created by lin on 5/21/17.
 */

public interface UnsplashService {
    @GET("photos") Call<List<PhotoPOJO>> listPhotos(@Header("Authorization") String token);

}
