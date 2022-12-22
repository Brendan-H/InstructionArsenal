/*
 * Copyright (c) 2022 by Brendan Haran, All Rights Reserved.
 * Use of this file or any of its contents is strictly prohibited without prior written permission from Brendan Haran.
 * Current File (OfficialInstructionsService.java) Last Modified on 12/22/22, 3:27 PM
 *
 */

package com.brendanharan.instructionarsenalbackend.officialInstructions;

import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

@Service @AllArgsConstructor
public class OfficialInstructionsService {

    @Autowired
    private OfficialInstructionsRepository officialInstructionsRepository;



    public void savePost(OfficialInstructions officialInstructions) {
        officialInstructionsRepository.save(officialInstructions);
    }

    public List<OfficialInstructions> getPosts(){
        return officialInstructionsRepository.findAll();
    }


}
