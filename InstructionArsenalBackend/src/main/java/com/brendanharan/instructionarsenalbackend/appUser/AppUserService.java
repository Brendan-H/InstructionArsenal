/*
 * Copyright (c) 2022 by Brendan Haran, All Rights Reserved.
 * Use of this file or any of its contents is strictly prohibited without prior written permission from Brendan Haran.
 * Current File (AppUserService.java) Last Modified on 12/21/22, 8:22 PM
 *
 */

package com.brendanharan.instructionarsenalbackend.appUser;

import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@AllArgsConstructor
public class AppUserService {

    private final AppUserRepository appUserRepository;


    public void saveUser(AppUser user) {
        appUserRepository.save(user);
    }


}
