/*
 * Copyright (c) 2022 by Brendan Haran, All Rights Reserved.
 * Use of this file or any of its contents is strictly prohibited without prior written permission from Brendan Haran.
 * Current File (OfficialInstructionsController.java) Last Modified on 12/22/22, 3:27 PM
 *
 */

package com.brendanharan.instructionarsenalbackend.officialInstructions;

import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@CrossOrigin
@RequestMapping("api/v1/instructions/officialinstructions")
@AllArgsConstructor
public class OfficialInstructionsController {


    private final OfficialInstructionsService postService;

    @PostMapping()
    public ResponseEntity createPost(@RequestBody OfficialInstructions officialInstructions)  {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        postService.savePost(officialInstructions);
        return new ResponseEntity(HttpStatus.CREATED);
    }

    @GetMapping()
    public ResponseEntity<List<OfficialInstructions>> getPosts() {
        return ResponseEntity.ok().body(postService.getPosts());
    }


}