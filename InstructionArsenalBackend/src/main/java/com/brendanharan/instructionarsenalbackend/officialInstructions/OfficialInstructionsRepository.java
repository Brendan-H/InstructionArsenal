/*
 * Copyright (c) 2022 by Brendan Haran, All Rights Reserved.
 * Use of this file or any of its contents is strictly prohibited without prior written permission from Brendan Haran.
 * Current File (OfficialInstructionsRepository.java) Last Modified on 12/22/22, 3:27 PM
 *
 */

package com.brendanharan.instructionarsenalbackend.officialInstructions;


import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


@Repository @Transactional(readOnly = true)
public interface OfficialInstructionsRepository extends JpaRepository<OfficialInstructions, Long> {


   // List<OfficialInstructions> findByTitleNear(String title);
    List<OfficialInstructions> findByTitle(String title);


    OfficialInstructions findAllById(Long id);

    List<OfficialInstructions> findAllByCreatedBy(String createdBy);

   List<OfficialInstructions> findAllByCompany(String company);
   //List<OfficialInstructions> findAllByCompanyNear(String company);



}
