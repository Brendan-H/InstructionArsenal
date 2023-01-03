/*
 * Copyright (c) 2022 by Brendan Haran, All Rights Reserved.
 * Use of this file or any of its contents is strictly prohibited without prior written permission from Brendan Haran.
 * Current File (CommunityMadeInstructions.java) Last Modified on 12/22/22, 3:28 PM
 *
 */

package com.brendanharan.instructionarsenalbackend.communitymadeinstructions;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter @Setter @NoArgsConstructor @Entity
public class CommunityMadeInstructions {

    @SequenceGenerator(
            name = "community_made_instructions_sequence",
            sequenceName = "community_made_instructions_sequence",
            allocationSize = 1
    )
    @Id
    @GeneratedValue(
            strategy = GenerationType.SEQUENCE,
            generator = "community_made_instructions_sequence"
    )
    private Long id;

    @Column(name="Title", length = 512)
    private String title;

    @Column(name = "Description", length = 2048)
    private String description;

    @Column(name="Company")
    private String company;

    @Column(name="PostCreatedAt")
    private LocalDateTime postCreatedAt = LocalDateTime.now();

    @Lob
    @Column(name="Instructions")
    private String instructions;

    @Column(name="CreatedBy")
    private String createdBy;

    @Column(name="Category")
    private String category;

//    @Lob
//    @Column(name = "file")
//    private byte[] file;
//TODO add file storage


    @Override
    public String toString() {
        return "CommunityMadeInstructions{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", description='" + description + '\'' +
                ", company='" + company + '\'' +
                ", postCreatedAt=" + postCreatedAt +
                ", instructions='" + instructions + '\'' +
                ", createdBy='" + createdBy + '\'' +
                '}';
    }

    public CommunityMadeInstructions(String title, String description, String company, LocalDateTime postCreatedAt, String instructions, String createdBy) {
        this.title = title;
        this.description = description;
        this.company = company;
        this.postCreatedAt = postCreatedAt;
        this.instructions = instructions;
        this.createdBy = createdBy;
    }
}
