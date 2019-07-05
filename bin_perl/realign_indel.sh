
# /data/bioit/biodata/zenghp/TMA/true_sample/new_pipeline_auto/Analysis/05.variant_detect/180707_L80705-22-13.GATK_realign_new.bam
perl realign_indel.pl -i /data/bioit/biodata/zenghp/TMA/true_sample/new_pipeline_auto/Analysis/05.variant_detect/180707_L80705-22-13.GATK_realign.bam -o /data/bioit/biodata/wugz/codes/learngit_test/test_perl/realign_indel_test/test_new.bam
samtools sort /data/bioit/biodata/wugz/codes/learngit_test/test_perl/realign_indel_test/test_new.bam >/data/bioit/biodata/wugz/codes/learngit_test/test_perl/realign_indel_test/test_new.sort.bam
samtools index /data/bioit/biodata/wugz/codes/learngit_test/test_perl/realign_indel_test/test_new.sort.bam



