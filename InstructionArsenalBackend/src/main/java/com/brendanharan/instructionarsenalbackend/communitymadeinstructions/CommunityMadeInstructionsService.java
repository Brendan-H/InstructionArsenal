/*
 * Copyright (c) 2023 by Brendan Haran, All Rights Reserved.
 * Use of this file or any of its contents is strictly prohibited without prior written permission from Brendan Haran.
 * Current File (CommunityMadeInstructionsService.java) Last Modified on 1/2/23, 8:45 PM
 *
 */

package com.brendanharan.instructionarsenalbackend.communitymadeinstructions;


import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service @AllArgsConstructor
public class CommunityMadeInstructionsService {

    @Autowired
    private CommunityMadeInstructionsRepository communityMadeInstructionsRepository;


    public List<CommunityMadeInstructions> findCommunityMadeInstructionsByTitleLike(String title) {
        return communityMadeInstructionsRepository.findByTitleLikeIgnoreCase(title);
    }
    public void saveCommunityMadeInstructions(CommunityMadeInstructions CommunityMadeInstructions) {
        communityMadeInstructionsRepository.save(CommunityMadeInstructions);
    }

    public List<CommunityMadeInstructions> findCommunityMadeInstructionsByTitleAndCategoryLike(String title, String category) {
        return communityMadeInstructionsRepository.findAllByTitleAndCategoryLikeIgnoreCase(title, category);
    }

    public void deleteCommunityMadeInstructions(Long id) {
        communityMadeInstructionsRepository.deleteById(id);
    }

    public List<CommunityMadeInstructions> getCommunityMadeInstructions(){
        return communityMadeInstructionsRepository.findAll();
    }

    public CommunityMadeInstructions findCommunityMadeInstructionsByID(Long id) {
        return communityMadeInstructionsRepository.findAllById(id);
    }

    public List<CommunityMadeInstructions> findCommunityMadeInstructionsByCreatedByExact(String createdBy) {
        return communityMadeInstructionsRepository.findAllByCreatedBy(createdBy);
    }
}
