/*
 * Copyright (c) 2022 by Brendan Haran, All Rights Reserved.
 * Use of this file or any of its contents is strictly prohibited without prior written permission from Brendan Haran.
 * Current File (AppUserController.java) Last Modified on 12/21/22, 8:22 PM
 *
 */

package com.brendanharan.instructionarsenalbackend.appUser;

import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseAuthException;
import com.google.firebase.auth.FirebaseToken;
import lombok.AllArgsConstructor;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("api/v1/users")
@CrossOrigin
@AllArgsConstructor
public class AppUserController {

    private final AppUserService userService;


    @GetMapping("/id/verify")
    public ResponseEntity<String> verifyId(@RequestHeader(value = "Authorization") String idToken ) throws FirebaseAuthException {
        HttpHeaders headers = new HttpHeaders();
        FirebaseToken decodedToken = FirebaseAuth.getInstance().verifyIdToken(idToken);
        String uid = decodedToken.getUid();
        headers.add("uid", uid);
        return new ResponseEntity<String>(uid, headers, HttpStatus.OK);
    }

    @PostMapping("/save")
    public ResponseEntity<AppUser> saveUser(@RequestHeader(value= "Authorization") String idToken) throws Exception {
        FirebaseToken decodedToken = FirebaseAuth.getInstance().verifyIdToken(idToken);
        String uid = decodedToken.getUid();
        String email = decodedToken.getEmail();
        AppUser user = new AppUser();
        user.setEmail(email);
        user.setUid(uid);

        userService.saveUser(user);

        return new ResponseEntity<>(HttpStatus.CREATED);
    }

}
