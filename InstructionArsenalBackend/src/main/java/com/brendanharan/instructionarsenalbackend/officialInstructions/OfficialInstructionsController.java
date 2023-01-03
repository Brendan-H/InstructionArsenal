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
import org.springframework.web.bind.annotation.*;


import java.util.List;

@RestController
@CrossOrigin
@RequestMapping("api/v1/instructions/officialinstructions")
@AllArgsConstructor
public class OfficialInstructionsController {


    private final OfficialInstructionsService officialInstructionsService;

    @PostMapping()
    public ResponseEntity createPost(@RequestBody OfficialInstructions officialInstructions)  {
        //Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        officialInstructionsService.saveOfficialInstructions(officialInstructions);
        return new ResponseEntity(HttpStatus.CREATED);
    }

    @GetMapping("/all")
    public ResponseEntity<List<OfficialInstructions>> getPosts() {
        return ResponseEntity.ok().body(officialInstructionsService.getOfficialInstructions());
    }

    @GetMapping("/{id}")
    OfficialInstructions findPostByID(@PathVariable Long id) {
        return officialInstructionsService.findOfficialInstructionsByID(id);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity deletePostByID(@PathVariable Long id) {
        officialInstructionsService.deleteOfficialInstructions(id);
        return ResponseEntity.ok("Official Instruction Deleted");
    }

    @GetMapping("/title/{title}")
    List<OfficialInstructions> findPostByTitle(@PathVariable String title) {
        return officialInstructionsService.findOfficialInstructionsByTitleLike(title);
    }
    @GetMapping("/titleandcompany/{company}/{title}")
    List<OfficialInstructions> findPostByTitleAndCompany(@PathVariable String title, @PathVariable String company) {
        return officialInstructionsService.findOfficialInstructionsByTitleAndCompanyLike(title, company);
    }


    @GetMapping("/createdby/{createdBy}")
    List<OfficialInstructions> findPostByCreatedBy(@PathVariable String createdBy) {
        return officialInstructionsService.findOfficialInstructionsByCreatedBy(createdBy);
    }
    @GetMapping("/createdbyexact/{createdBy}")
    List<OfficialInstructions> findPostByCreatedByExact(@PathVariable String createdBy) {
        return officialInstructionsService.findOfficialInstructionsByCreatedByExact(createdBy);
    }

    @GetMapping("/company/{company}")
    List<OfficialInstructions> findPostByCompany(@PathVariable String company) {
        return officialInstructionsService.findOfficialInstructionsByCompany(company);
    }


}