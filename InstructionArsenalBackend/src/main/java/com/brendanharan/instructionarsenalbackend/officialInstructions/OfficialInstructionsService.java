/*
 * Copyright (c) 2022 by Brendan Haran, All Rights Reserved.
 * Use of this file or any of its contents is strictly prohibited without prior written permission from Brendan Haran.
 * Current File (OfficialInstructionsService.java) Last Modified on 12/22/22, 3:27 PM
 *
 */

package com.brendanharan.instructionarsenalbackend.officialInstructions;


import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.*;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@Service @AllArgsConstructor
public class OfficialInstructionsService {

    @Autowired
    private OfficialInstructionsRepository officialInstructionsRepository;



    //find out how to fix this
    @Query(value = "SELECT * FROM official_instructions WHERE title LIKE :title", nativeQuery = true)
    public List<OfficialInstructions> findOfficialInstructionsByTitleLike(String title) {
        System.out.println("\n\n\n\n\n" + title);
        return officialInstructionsRepository.findByTitle(title);
    }

    public void saveOfficialInstructions(OfficialInstructions officialInstructions) {
        officialInstructionsRepository.save(officialInstructions);
    }

    public void deleteOfficialInstructions(Long id) {
        officialInstructionsRepository.deleteById(id);
       // officialInstructionsRepository.deleteOfficialInstructionsById(id);
    }

    public List<OfficialInstructions> getOfficialInstructions(){
        return officialInstructionsRepository.findAll();
    }


    public List<OfficialInstructions> findOfficialInstructionsByTitle(String title) {
        return officialInstructionsRepository.findByTitle(title);
    }

    public OfficialInstructions findOfficialInstructionsByID(Long id) {
        return officialInstructionsRepository.findAllById(id);
    }

    public List<OfficialInstructions> findOfficialInstructionsByCreatedBy(String createdBy) {
        return officialInstructionsRepository.findAllByCreatedBy(createdBy);
    }

    public List<OfficialInstructions> findOfficialInstructionsByCompany(String company) {
        return officialInstructionsRepository.findAllByCompany(company);
    }
//    public List<OfficialInstructions> findOfficialInstructionsByCompanyNear(String company) {
//        return officialInstructionsRepository.findAllByCompanyNear(company);
//    }
}

