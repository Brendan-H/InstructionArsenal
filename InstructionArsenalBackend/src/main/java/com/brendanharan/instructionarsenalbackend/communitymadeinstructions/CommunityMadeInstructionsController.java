/*
 * Copyright (c) 2023 by Brendan Haran, All Rights Reserved.
 * Use of this file or any of its contents is strictly prohibited without prior written permission from Brendan Haran.
 * Current File (CommunityMadeInstructionsController.java) Last Modified on 1/2/23, 9:04 PM
 *
 */

package com.brendanharan.instructionarsenalbackend.communitymadeinstructions;
import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;


import java.util.List;

@RestController
@CrossOrigin
@RequestMapping("api/v1/instructions/communitymadeinstructions")
@AllArgsConstructor
public class CommunityMadeInstructionsController {


    private final CommunityMadeInstructionsService communityMadeInstructionsService;

    @PostMapping()
    public ResponseEntity createPost(@RequestBody CommunityMadeInstructions communityMadeInstructions)  {
        communityMadeInstructionsService.saveCommunityMadeInstructions(communityMadeInstructions);
        return new ResponseEntity(HttpStatus.CREATED);
    }

    @GetMapping("/all")
    public ResponseEntity<List<CommunityMadeInstructions>> getPosts() {
        return ResponseEntity.ok().body(communityMadeInstructionsService.getCommunityMadeInstructions());
    }

    @GetMapping("/{id}")
    CommunityMadeInstructions findPostByID(@PathVariable Long id) {
        return communityMadeInstructionsService.findCommunityMadeInstructionsByID(id);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity deletePostByID(@PathVariable Long id) {
        communityMadeInstructionsService.deleteCommunityMadeInstructions(id);
        return ResponseEntity.ok("Official Instruction Deleted");
    }

    @GetMapping("/title/{title}")
    List<CommunityMadeInstructions> findPostByTitle(@PathVariable String title) {
        return communityMadeInstructionsService.findCommunityMadeInstructionsByTitleLike(title);
    }


    @GetMapping("/createdbyexact/{createdBy}")
    List<CommunityMadeInstructions> findPostByCreatedByExact(@PathVariable String createdBy) {
        return communityMadeInstructionsService.findCommunityMadeInstructionsByCreatedByExact(createdBy);
    }

    @GetMapping("/titleandcategoryandsubcategory/{title}/{category}/{subCategory}")
    List<CommunityMadeInstructions> findPostByTitleAndCategoryAndSubCategory(@PathVariable String title, @PathVariable String category, @PathVariable String subCategory) {
        return communityMadeInstructionsService.findCommunityMadeInstructionsByTitleAndCategoryAndSubcategoryLike(title, category, subCategory);
    }



}