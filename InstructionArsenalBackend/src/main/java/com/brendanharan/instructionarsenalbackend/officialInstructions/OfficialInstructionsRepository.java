/*
 * Copyright (c) 2022 by Brendan Haran, All Rights Reserved.
 * Use of this file or any of its contents is strictly prohibited without prior written permission from Brendan Haran.
 * Current File (OfficialInstructionsRepository.java) Last Modified on 12/22/22, 3:27 PM
 *
 */

package com.brendanharan.instructionarsenalbackend.officialInstructions;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;


@Repository @Transactional(readOnly = true)
public interface OfficialInstructionsRepository extends JpaRepository<OfficialInstructions, Long> {


    OfficialInstructions findByTitle(String title);

   // OfficialInstructions findbyCompany(String company);



}
